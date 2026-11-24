import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';
import '../entities/note.dart';

abstract interface class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();

  Future<Either<Failure, Note>> addNote({
    required String title,
    required String content,
    int colorIndex = 0,
  });

  Future<Either<Failure, Note>> updateNote(Note note);

  Future<Either<Failure, Unit>> deleteNote(String id);
}
