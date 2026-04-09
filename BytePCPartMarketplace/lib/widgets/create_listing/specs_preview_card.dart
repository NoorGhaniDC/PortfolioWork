import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/catalog/specs_schema.dart';
import '../../../models/parts_catalog_model.dart';

class SpecsPreviewCard extends StatelessWidget {
  final PartsCatalogModel part;

  const SpecsPreviewCard({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    final schemaFields = SpecsSchema.schema[part.category];
    final specItems = schemaFields != null
        ? schemaFields
            .where((f) => part.specs.containsKey(f.key))
            .map((f) => _SpecItem(
                  label: f.label,
                  value: f.type.format(part.specs[f.key]),
                ))
            .toList()
        : part.specs.entries
            .map((e) => _SpecItem(label: e.key, value: '${e.value}'))
            .toList();

    return Card(
      color: AppColors.primary.withValues(alpha: 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle_outline,
                    color: AppColors.success, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    part.displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Specifications',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children: specItems.map((item) => _SpecChip(item: item)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Internal models & chip — scoped to this file ───────────────────────────

class _SpecItem {
  final String label;
  final String value;
  const _SpecItem({required this.label, required this.value});
}

class _SpecChip extends StatelessWidget {
  final _SpecItem item;
  const _SpecChip({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
