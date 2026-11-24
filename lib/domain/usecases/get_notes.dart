import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

@lazySingleton
class GetNotes implements UseCase<List<Note>, NoParams> {
  const GetNotes(this._repository);

  final NoteRepository _repository;

  @override
  Future<Either<Failure, List<Note>>> call(NoParams params) {
    return _repository.getNotes();
  }
}
