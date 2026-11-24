import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../domain/entities/note.dart';
import '../../../../domain/usecases/add_note.dart';
import '../../../../domain/usecases/delete_note.dart';
import '../../../../domain/usecases/get_notes.dart';
import '../../../../domain/usecases/update_note.dart';

part 'notes_state.dart';
part 'notes_cubit.freezed.dart';

@injectable
class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this._getNotes, this._addNote, this._updateNote, this._deleteNote)
    : super(const NotesState.initial());

  final GetNotes _getNotes;
  final AddNote _addNote;
  final UpdateNote _updateNote;
  final DeleteNote _deleteNote;

  Future<void> loadNotes() async {
    emit(state.copyWith(status: NotesStatus.loading, errorMessage: null));

    final result = await _getNotes(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: NotesStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (notes) =>
          emit(state.copyWith(status: NotesStatus.success, notes: notes)),
    );
  }

  Future<void> addNote({
    required String title,
    required String content,
    int colorIndex = 0,
  }) async {
    _clearError();
    final result = await _addNote(
      AddNoteParams(title: title, content: content, colorIndex: colorIndex),
    );
    result.fold(
      _emitError,
      (note) => emit(state.copyWith(notes: [note, ...state.notes])),
    );
  }

  Future<void> updateNote(Note note) async {
    _clearError();
    final result = await _updateNote(note);
    result.fold(
      _emitError,
      (updated) => emit(
        state.copyWith(
          notes: [updated, ...state.notes.where((n) => n.id != updated.id)],
        ),
      ),
    );
  }

  Future<void> deleteNote(String id) async {
    final previous = state.notes;
    emit(
      state.copyWith(
        notes: previous.where((n) => n.id != id).toList(),
        errorMessage: null,
      ),
    );

    final result = await _deleteNote(id);
    result.fold(
      (failure) =>
          emit(state.copyWith(notes: previous, errorMessage: failure.message)),
      (_) {},
    );
  }

  void searchChanged(String query) => emit(state.copyWith(query: query));

  void _clearError() => emit(state.copyWith(errorMessage: null));

  void _emitError(Failure failure) {
    emit(state.copyWith(errorMessage: failure.message));
  }
}
