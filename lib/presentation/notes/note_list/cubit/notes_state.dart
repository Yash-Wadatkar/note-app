part of 'notes_cubit.dart';

enum NotesStatus { initial, loading, success, failure }

@freezed
abstract class NotesState with _$NotesState {
  const factory NotesState.initial({
    @Default(NotesStatus.initial) NotesStatus status,
    @Default([]) List<Note> notes,
    @Default('') String query,
    String? errorMessage,
  }) = _Initial;
}

extension NotesStateX on NotesState {
  List<Note> get visibleNotes {
    final term = query.trim().toLowerCase();
    if (term.isEmpty) return notes;

    return notes
        .where(
          (note) =>
              note.title.toLowerCase().contains(term) ||
              note.content.toLowerCase().contains(term),
        )
        .toList();
  }
}
