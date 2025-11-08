import 'package:flutter/material.dart';

/// Панель фильтрации: Все / Уходовая / Парфюмерия / Декоративная.
/// selected == null → без фильтра.
class CategoryFilterBar extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;

  const CategoryFilterBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const categories = <String>[
    'Уходовая',
    'Парфюмерия',
    'Декоративная',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          label: const Text('Все'),
          selected: selected == null,
          onSelected: (_) => onChanged(null),
        ),
        ...categories.map((c) => FilterChip(
          label: Text(c),
          selected: selected == c,
          onSelected: (_) => onChanged(selected == c ? null : c),
        )),
      ],
    );
  }
}
