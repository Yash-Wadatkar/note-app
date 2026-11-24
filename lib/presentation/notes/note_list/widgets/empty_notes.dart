import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class EmptyNotes extends StatelessWidget {
  const EmptyNotes({super.key, this.searchQuery});

  final String? searchQuery;

  @override
  Widget build(BuildContext context) {
    final isSearching = searchQuery?.isNotEmpty ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearching ? Icons.search_off_rounded : Icons.note_alt_outlined,
            size: 72,
            color: AppColors.muted,
          ),
          const SizedBox(height: 20),
          Text(
            isSearching ? 'No results' : 'No notes yet',
            style: AppTheme.display(size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            isSearching
                ? 'No notes match “$searchQuery”.'
                : 'Tap New note to write your first one.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.inkSoft,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
