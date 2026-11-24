import 'dart:math' as math;

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
          if (!isSearching) ...[_buildPaperStack(), const SizedBox(height: 32)],
          Text(
            isSearching ? 'Nothing found' : 'A blank page',
            style: AppTheme.display(size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            isSearching
                ? 'No notes match “$searchQuery”.'
                : 'Ideas, lists, the thing you’ll forget by tonight — jot it down.',
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

Widget _buildPaperStack() {
  return SizedBox(
    width: 150,
    height: 130,
    child: Stack(
      alignment: Alignment.center,
      children: [
        _buildSheet(
          NotePalette.of(4),
          angle: -10,
          offset: const Offset(-22, 6),
        ),
        _buildSheet(NotePalette.of(2), angle: 8, offset: const Offset(22, 2)),
        _buildSheet(
          NotePalette.of(1),
          angle: -2,
          offset: Offset.zero,
          lined: true,
        ),
      ],
    ),
  );
}

Widget _buildSheet(
  Color color, {
  required double angle,
  required Offset offset,
  bool lined = false,
}) {
  return Transform.translate(
    offset: offset,
    child: Transform.rotate(
      angle: angle * math.pi / 180,
      child: Container(
        width: 84,
        height: 100,
        padding: const EdgeInsets.fromLTRB(14, 18, 14, 0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: lined
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final width in [44.0, 56.0, 36.0, 50.0])
                    Container(
                      width: width,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 9),
                      decoration: BoxDecoration(
                        color: AppColors.ink.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                ],
              )
            : null,
      ),
    ),
  );
}
