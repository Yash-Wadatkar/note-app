import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/notes_cubit.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final _controller = TextEditingController(
    text: context.read<NotesCubit>().state.query,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    context.read<NotesCubit>().searchChanged('');
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: AppColors.line),
    );

    return TextField(
      controller: _controller,
      onChanged: context.read<NotesCubit>().searchChanged,
      textInputAction: TextInputAction.search,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        hintText: 'Search your notes',
        hintStyle: const TextStyle(color: AppColors.muted),
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.muted),
        suffixIcon: BlocBuilder<NotesCubit, NotesState>(
          buildWhen: (p, c) => p.query.isEmpty != c.query.isEmpty,
          builder: (context, state) => state.query.isNotEmpty
              ? IconButton(
                  onPressed: _clear,
                  icon: const Icon(Icons.close_rounded, size: 20),
                  color: AppColors.muted,
                )
              : const SizedBox.shrink(),
        ),
        filled: true,
        fillColor: AppColors.paper,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: AppColors.inkSoft),
        ),
      ),
    );
  }
}
