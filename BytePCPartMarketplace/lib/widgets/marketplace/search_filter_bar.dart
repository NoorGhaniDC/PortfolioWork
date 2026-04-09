import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'marketplace_filters.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final List<String> categories;
  final List<String> conditions;
  final String selectedCategory;
  final String selectedCondition;
  final Function(String) onSearchChanged;
  final Function(String?) onCategoryChanged;
  final Function(String?) onConditionChanged;
  final VoidCallback onClearFilters;

  const SearchFilterBar({
    required this.searchController,
    required this.categories,
    required this.conditions,
    required this.selectedCategory,
    required this.selectedCondition,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.onConditionChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 768;

    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(16),
      // Center and cap width so filters don't stretch across a 4K screen
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isWide ? _buildWideLayout() : _buildNarrowLayout(),
        ),
      ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        // Search takes all remaining space
        Expanded(
          child: SearchField(
            controller: searchController,
            onChanged: onSearchChanged,
          ),
        ),
        const SizedBox(width: 12),
        // Fixed widths prevent dropdowns from collapsing or overflowing
        SizedBox(
          width: 160,
          child: CategoryDropdown(
            categories: categories,
            selected: selectedCategory,
            onChanged: onCategoryChanged,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 140,
          child: ConditionDropdown(
            conditions: conditions,
            selected: selectedCondition,
            onChanged: onConditionChanged,
          ),
        ),
        const SizedBox(width: 12),
        Tooltip(
          message: 'Reset all filters and search',
          child: TextButton.icon(
            onPressed: onClearFilters,
            icon: const Icon(Icons.clear, size: 16),
            label: const Text('Clear'),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        SearchField(controller: searchController, onChanged: onSearchChanged),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CategoryDropdown(
                categories: categories,
                selected: selectedCategory,
                onChanged: onCategoryChanged,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ConditionDropdown(
                conditions: conditions,
                selected: selectedCondition,
                onChanged: onConditionChanged,
              ),
            ),
            Tooltip(
              message: 'Reset all filters and search',
              child: TextButton(
                onPressed: onClearFilters,
                child: const Text('Clear'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
