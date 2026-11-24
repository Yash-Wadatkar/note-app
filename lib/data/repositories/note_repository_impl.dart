import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/local_datasource/note_local_data_source.dart';
import '../models/note_model.dart';

@LazySingleton(as: NoteRepository)
class NoteRepositoryImpl implements NoteRepository {
  const NoteRepositoryImpl(this._localDataSource, this._uuid);

  final NoteLocalDataSource _localDataSource;
  final Uuid _uuid;

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      return Right(_localDataSource.getNotes());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Note>> addNote({
    required String title,
    required String content,
    int colorIndex = 0,
  }) async {
    final now = DateTime.now();
    final note = NoteModel(
      id: _uuid.v4(),
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
      colorIndex: colorIndex,
    );

    try {
      await _localDataSource.saveNote(note);
      return Right(note);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Note>> updateNote(Note note) async {
    if (_localDataSource.getNote(note.id) == null) {
      return Left(NotFoundFailure('Note ${note.id} does not exist'));
    }

    try {
      final model = NoteModel.fromEntity(note);
      await _localDataSource.saveNote(model);
      return Right(model);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(String id) async {
    try {
      await _localDataSource.deleteNote(id);
      return const Right(unit);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
