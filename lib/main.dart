import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'presentation/notes/note_list/cubit/notes_cubit.dart';
import 'presentation/notes/note_list/notes_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotesCubit>()..loadNotes(),
      child: MaterialApp(
        title: 'Notes',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const NotesPage(),
      ),
    );
  }
}
