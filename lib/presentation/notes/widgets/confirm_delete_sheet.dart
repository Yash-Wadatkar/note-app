import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

Future<bool> showConfirmDeleteSheet(
  BuildContext context, {
  String? title,
}) async {
  final confirmed = await showModalBottomSheet<bool>(
    context: context,
    builder: (context) => _buildConfirmDeleteSheet(context, title: title),
  );
  return confirmed ?? false;
}

Widget _buildConfirmDeleteSheet(BuildContext context, {String? title}) {
  final noteName = (title?.isNotEmpty ?? false) ? '“$title”' : 'this note';

  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delete note?', style: AppTheme.display(size: 24)),
          const SizedBox(height: 8),
          Text(
            'You’re about to delete $noteName. This can’t be undone.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.inkSoft,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: _sheetButtonStyle(
                    OutlinedButton.styleFrom(
                      foregroundColor: AppColors.ink,
                      side: const BorderSide(color: AppColors.line),
                    ),
                  ),
                  child: const Text('Keep it'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: _sheetButtonStyle(
                    FilledButton.styleFrom(backgroundColor: AppColors.danger),
                  ),
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

ButtonStyle _sheetButtonStyle(ButtonStyle style) {
  return style.copyWith(
    minimumSize: const WidgetStatePropertyAll(Size.fromHeight(52)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
}
