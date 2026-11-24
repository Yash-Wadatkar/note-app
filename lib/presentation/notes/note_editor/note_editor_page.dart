import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../domain/entities/note.dart';
import 'cubit/note_editor_cubit.dart';
import 'widgets/color_picker.dart';
import '../widgets/confirm_delete_sheet.dart';

class NoteEditorPage extends StatelessWidget {
  const NoteEditorPage({super.key, this.note});

  final Note? note;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteEditorCubit(note),
      // Builder gives a context below the provider so the cubit can be read.
      child: Builder(builder: _buildEditor),
    );
  }
}

Widget _buildEditor(BuildContext context) {
  final cubit = context.read<NoteEditorCubit>();

  return BlocListener<NoteEditorCubit, NoteEditorState>(
    listenWhen: (previous, current) =>
        previous.status != current.status &&
        current.status != NoteEditorStatus.editing,
    listener: (context, state) => Navigator.of(context).pop(state.result),
    child: PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) cubit.finish();
      },
      child: BlocBuilder<NoteEditorCubit, NoteEditorState>(
        buildWhen: (p, c) => p.colorIndex != c.colorIndex,
        builder: (context, state) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          color: NotePalette.of(state.colorIndex),
          child: _buildScaffold(context, cubit),
        ),
      ),
    ),
  );
}

Widget _buildScaffold(BuildContext context, NoteEditorCubit cubit) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    appBar: AppBar(
      leading: _buildRoundButton(
        icon: Icons.arrow_back_rounded,
        tooltip: 'Back',
        onPressed: cubit.finish,
      ),
      actions: [
        if (!cubit.state.isNewNote)
          _buildRoundButton(
            icon: Icons.delete_outline_rounded,
            tooltip: 'Delete',
            onPressed: () => _confirmDelete(context, cubit),
          ),
        const SizedBox(width: 8),
        _buildDoneButton(onPressed: cubit.finish),
        const SizedBox(width: 16),
      ],
    ),
    body: SafeArea(
      top: false,
      child: Column(
        children: [
          Expanded(child: _buildFields(context, cubit)),
          _buildColorToolbar(cubit),
        ],
      ),
    ),
  );
}

Future<void> _confirmDelete(BuildContext context, NoteEditorCubit cubit) async {
  FocusScope.of(context).unfocus();
  final confirmed = await showConfirmDeleteSheet(
    context,
    title: cubit.state.title.trim(),
  );
  if (confirmed) cubit.delete();
}

Widget _buildFields(BuildContext context, NoteEditorCubit cubit) {
  final initial = cubit.state;
  final titleStyle = AppTheme.display(size: 30);

  return ListView(
    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    children: [
      TextFormField(
        initialValue: initial.title,
        onChanged: cubit.titleChanged,
        autofocus: initial.isNewNote,
        maxLines: null,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        style: titleStyle,
        decoration: InputDecoration.collapsed(
          hintText: 'Title',
          hintStyle: titleStyle.copyWith(
            color: AppColors.ink.withValues(alpha: 0.28),
          ),
        ),
      ),
      const SizedBox(height: 10),
      _buildMetaLine(context, initial.initialNote),
      const SizedBox(height: 20),
      TextFormField(
        initialValue: initial.content,
        onChanged: cubit.contentChanged,
        maxLines: null,
        minLines: 12,
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.ink,
          height: 1.6,
          fontSize: 16.5,
        ),
        decoration: InputDecoration.collapsed(
          hintText: 'Start writing…',
          hintStyle: TextStyle(color: AppColors.ink.withValues(alpha: 0.35)),
        ),
      ),
    ],
  );
}

Widget _buildMetaLine(BuildContext context, Note? note) {
  final date = note == null ? 'New note' : formatFullDate(note.updatedAt);
  final style = Theme.of(context).textTheme.labelMedium?.copyWith(
    color: AppColors.ink.withValues(alpha: 0.5),
    letterSpacing: 0.2,
  );

  return BlocBuilder<NoteEditorCubit, NoteEditorState>(
    buildWhen: (p, c) => p.wordCount != c.wordCount,
    builder: (context, state) {
      final words = state.wordCount;
      final wordLabel = words == 1 ? '1 word' : '$words words';
      return Text('$date  ·  $wordLabel', style: style);
    },
  );
}

Widget _buildColorToolbar(NoteEditorCubit cubit) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: AppColors.ink.withValues(alpha: 0.08)),
      ),
    ),
    child: BlocBuilder<NoteEditorCubit, NoteEditorState>(
      buildWhen: (p, c) => p.colorIndex != c.colorIndex,
      builder: (context, state) => NoteColorPicker(
        selectedIndex: state.colorIndex,
        onSelected: cubit.colorSelected,
      ),
    ),
  );
}

Widget _buildRoundButton({
  required IconData icon,
  required String tooltip,
  required VoidCallback onPressed,
}) {
  return Center(
    child: IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, size: 22),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.55),
        foregroundColor: AppColors.ink,
        fixedSize: const Size(42, 42),
      ),
    ),
  );
}

Widget _buildDoneButton({required VoidCallback onPressed}) {
  return FilledButton(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.ink,
      foregroundColor: Colors.white,
      minimumSize: const Size(0, 42),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
    child: const Text('Done'),
  );
}
