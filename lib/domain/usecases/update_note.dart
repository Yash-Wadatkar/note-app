import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

@lazySingleton
class UpdateNote implements UseCase<Note, Note> {
  const UpdateNote(this._repository);

  final NoteRepository _repository;

  @override
  Future<Either<Failure, Note>> call(Note note) {
    return _repository.updateNote(
      note.copyWith(
        title: note.title.trim(),
        content: note.content.trim(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}
