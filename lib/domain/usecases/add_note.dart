import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

@lazySingleton
class AddNote implements UseCase<Note, AddNoteParams> {
  const AddNote(this._repository);

  final NoteRepository _repository;

  @override
  Future<Either<Failure, Note>> call(AddNoteParams params) {
    return _repository.addNote(
      title: params.title.trim(),
      content: params.content.trim(),
      colorIndex: params.colorIndex,
    );
  }
}

class AddNoteParams extends Equatable {
  const AddNoteParams({
    required this.title,
    required this.content,
    this.colorIndex = 0,
  });

  final String title;
  final String content;
  final int colorIndex;

  @override
  List<Object?> get props => [title, content, colorIndex];
}
