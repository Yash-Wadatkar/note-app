sealed class NoteEditorResult {
  const NoteEditorResult();
}

class NoteSaved extends NoteEditorResult {
  const NoteSaved({
    required this.title,
    required this.content,
    required this.colorIndex,
  });

  final String title;
  final String content;
  final int colorIndex;
}

class NoteDeleted extends NoteEditorResult {
  const NoteDeleted();
}
