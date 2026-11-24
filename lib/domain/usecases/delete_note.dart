import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/note_repository.dart';

@lazySingleton
class DeleteNote implements UseCase<Unit, String> {
  const DeleteNote(this._repository);

  final NoteRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String id) {
    return _repository.deleteNote(id);
  }
}
