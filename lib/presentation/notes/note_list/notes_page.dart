import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/note.dart';
import '../models/note_editor_result.dart';
import '../note_editor/note_editor_page.dart';
import '../widgets/confirm_delete_sheet.dart';
import 'cubit/notes_cubit.dart';
import 'widgets/empty_notes.dart';
import 'widgets/note_card.dart';
import 'widgets/search_field.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NotesCubit, NotesState>(
        listenWhen: (p, c) {
          return p.errorMessage != c.errorMessage && c.errorMessage != null;
        },
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        },
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              BlocBuilder<NotesCubit, NotesState>(
                buildWhen: (p, c) => p.notes.length != c.notes.length,
                builder: (context, state) => SliverToBoxAdapter(
                  child: _buildHeader(context, noteCount: state.notes.length),
                ),
              ),
              BlocBuilder<NotesCubit, NotesState>(
                buildWhen: (p, c) => p.notes.isEmpty != c.notes.isEmpty,
                builder: (context, state) {
                  if (state.notes.isEmpty) {
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  }
                  return const SliverPadding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    sliver: SliverToBoxAdapter(child: SearchField()),
                  );
                },
              ),
              BlocBuilder<NotesCubit, NotesState>(
                buildWhen: (p, c) {
                  var c1 = p.status != c.status;
                  var c2 = p.notes != c.notes;
                  var c3 = p.query != c.query;
                  return c1 || c2 || c3;
                },
                builder: (context, state) => _buildBody(context, state),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(context),
        icon: const Icon(Icons.edit_rounded, size: 20),
        label: const Text('New note'),
      ),
    );
  }
}

Future<void> _openEditor(BuildContext context, [Note? note]) async {
  final cubit = context.read<NotesCubit>();
  final result = await Navigator.of(context).push<NoteEditorResult>(
    MaterialPageRoute(builder: (_) => NoteEditorPage(note: note)),
  );

  switch (result) {
    case NoteSaved(:final title, :final content, :final colorIndex):
      if (note == null) {
        cubit.addNote(title: title, content: content, colorIndex: colorIndex);
      } else {
        cubit.updateNote(
          note.copyWith(title: title, content: content, colorIndex: colorIndex),
        );
      }
    case NoteDeleted():
      if (note != null) cubit.deleteNote(note.id);
    case null:
      break;
  }
}

Future<void> _confirmDelete(BuildContext context, Note note) async {
  final cubit = context.read<NotesCubit>();
  final confirmed = await showConfirmDeleteSheet(context, title: note.title);
  if (confirmed) cubit.deleteNote(note.id);
}

Widget _buildBody(BuildContext context, NotesState state) {
  switch (state.status) {
    case NotesStatus.initial:
    case NotesStatus.loading:
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.ink,
          ),
        ),
      );
    case NotesStatus.failure:
      return SliverFillRemaining(
        hasScrollBody: false,
        child: _buildLoadError(
          onRetry: () => context.read<NotesCubit>().loadNotes(),
        ),
      );
    case NotesStatus.success:
      final notes = state.visibleNotes;
      if (notes.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyNotes(searchQuery: state.query.trim()),
        );
      }
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverList.separated(
          itemCount: notes.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteCard(
              key: ValueKey(note.id),
              note: note,
              onTap: () => _openEditor(context, note),
              onLongPress: () => _confirmDelete(context, note),
            );
          },
        ),
      );
  }
}

Widget _buildHeader(BuildContext context, {required int noteCount}) {
  final textTheme = Theme.of(context).textTheme;
  final today = DateFormat('EEEE, d MMMM').format(DateTime.now());
  final countLabel = switch (noteCount) {
    0 => 'Nothing here yet',
    1 => '1 note',
    _ => '$noteCount notes',
  };

  return Padding(
    padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          today.toUpperCase(),
          style: textTheme.labelSmall?.copyWith(
            color: AppColors.muted,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('Notes', style: AppTheme.display(size: 40)),
            const SizedBox(width: 12),
            Text(
              countLabel,
              style: textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLoadError({required VoidCallback onRetry}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Couldn’t load your notes', style: AppTheme.display(size: 22)),
      const SizedBox(height: 12),
      OutlinedButton(
        onPressed: onRetry,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Try again'),
      ),
    ],
  );
}
