import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search for PC components by name or keywords',
        prefixIcon: const Icon(Icons.search),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class CategoryDropdown extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final Function(String?) onChanged;

  const CategoryDropdown({
    required this.categories,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Filter by PC component category',
      child: DropdownButtonFormField<String>(
        initialValue: selected,
        isExpanded: true, // prevents text overflow clipping inside the widget
        decoration: InputDecoration(
          labelText: 'Category',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        items: categories
            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class ConditionDropdown extends StatelessWidget {
  final List<String> conditions;
  final String selected;
  final Function(String?) onChanged;

  const ConditionDropdown({
    required this.conditions,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Filter by item condition',
      child: DropdownButtonFormField<String>(
        initialValue: selected,
        isExpanded: true, // prevents text overflow clipping inside the widget
        decoration: InputDecoration(
          labelText: 'Condition',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        items: conditions
            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
