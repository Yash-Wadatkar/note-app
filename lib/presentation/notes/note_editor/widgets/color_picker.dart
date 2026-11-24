import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class NoteColorPicker extends StatelessWidget {
  const NoteColorPicker({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: NotePalette.colors.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) => _buildSwatch(
          index: index,
          isSelected: index == selectedIndex,
          onTap: () => onSelected(index),
        ),
      ),
    );
  }
}

Widget _buildSwatch({
  required int index,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: NotePalette.of(index),
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.ink : AppColors.line,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: isSelected ? 1 : 0,
        child: const Icon(Icons.check_rounded, size: 18, color: AppColors.ink),
      ),
    ),
  );
}
