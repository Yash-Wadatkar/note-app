part of 'note_editor_cubit.dart';

enum NoteEditorStatus { editing, closed, deleted }

@freezed
abstract class NoteEditorState with _$NoteEditorState {
  const factory NoteEditorState.initial({
    Note? initialNote,
    @Default('') String title,
    @Default('') String content,
    @Default(0) int colorIndex,
    @Default(NoteEditorStatus.editing) NoteEditorStatus status,
  }) = _Initial;
}

extension NoteEditorStateX on NoteEditorState {
  bool get isNewNote => initialNote == null;

  bool get isBlank => title.trim().isEmpty && content.trim().isEmpty;

  bool get hasChanges =>
      title.trim() != (initialNote?.title ?? '') ||
      content.trim() != (initialNote?.content ?? '') ||
      colorIndex != (initialNote?.colorIndex ?? 0);

  int get wordCount =>
      content.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;

  NoteEditorResult? get result => switch (status) {
    NoteEditorStatus.editing => null,
    NoteEditorStatus.deleted => const NoteDeleted(),
    NoteEditorStatus.closed when isBlank || !hasChanges => null,
    NoteEditorStatus.closed => NoteSaved(
      title: title.trim(),
      content: content.trim(),
      colorIndex: colorIndex,
    ),
  };
}
