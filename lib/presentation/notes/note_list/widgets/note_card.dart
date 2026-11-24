import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../domain/entities/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onLongPress,
  });

  final Note note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasTitle = note.title.isNotEmpty;
    final isPaper = note.colorIndex == 0;

    return Material(
      color: NotePalette.of(note.colorIndex),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: isPaper
            ? const BorderSide(color: AppColors.line)
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      hasTitle ? note.title : 'Untitled',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.display(size: 18).copyWith(
                        color: hasTitle ? AppColors.ink : AppColors.muted,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      formatShortDate(note.updatedAt),
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.ink.withValues(alpha: 0.45),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (note.content.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  note.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.inkSoft,
                    height: 1.45,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
