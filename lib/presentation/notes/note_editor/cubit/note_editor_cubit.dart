import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/note.dart';
import '../../models/note_editor_result.dart';

part 'note_editor_state.dart';
part 'note_editor_cubit.freezed.dart';

class NoteEditorCubit extends Cubit<NoteEditorState> {
  NoteEditorCubit(Note? note)
    : super(
        NoteEditorState.initial(
          initialNote: note,
          title: note?.title ?? '',
          content: note?.content ?? '',
          colorIndex: note?.colorIndex ?? 0,
        ),
      );

  bool get _isEditing => state.status == NoteEditorStatus.editing;

  void titleChanged(String title) => emit(state.copyWith(title: title));

  void contentChanged(String content) {
    emit(state.copyWith(content: content));
  }

  void colorSelected(int index) => emit(state.copyWith(colorIndex: index));

  void finish() {
    if (_isEditing) emit(state.copyWith(status: NoteEditorStatus.closed));
  }

  void delete() {
    if (_isEditing) emit(state.copyWith(status: NoteEditorStatus.deleted));
  }
}
