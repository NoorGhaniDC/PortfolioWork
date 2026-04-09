import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'listing_detail_widgets.dart';

class ImagePanel extends StatelessWidget {
  final List<String> imageUrls;
  final String category;
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;

  const ImagePanel({
    required this.imageUrls,
    required this.category,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.computer, size: 80, color: AppColors.primary),
            const SizedBox(height: 12),
            Text(
              category,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Main image
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: FirebaseImageLoader(
              imageUrl: imageUrls[currentIndex],
            ),
          ),
        ),

        // Thumbnail strip — shown only when there are multiple images
        if (imageUrls.length > 1) ...[
          const SizedBox(height: 12),
          SizedBox(
            height: 72,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () => onIndexChanged(i),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 72,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: i == currentIndex
                            ? AppColors.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FirebaseImageLoader(
                      imageUrl: imageUrls[i],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
