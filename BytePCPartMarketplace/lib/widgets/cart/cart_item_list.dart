import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/cart_provider.dart';
import 'small_badge.dart';
import 'cart_placeholder_thumb.dart';
import 'guide_section.dart';

class CartItemList extends StatelessWidget {
  final NumberFormat currencyFormat;

  const CartItemList({required this.currencyFormat, super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cart (${cartProvider.itemCount} ${cartProvider.itemCount == 1 ? 'item' : 'items'})',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () => _showPCBuildingGuide(context),
              child: Tooltip(
                message:
                    'View a helpful guide to PC components and compatibility',
                child: const Text('New to PC building?'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...cartProvider.items.map((item) {
          final listing = item.listing;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: listing.imageUrls.isNotEmpty
                        ? Image.network(
                            listing.imageUrls.first,
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const CartPlaceholderThumb(),
                          )
                        : const CartPlaceholderThumb(),
                  ),
                  const SizedBox(width: 16),

                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listing.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SmallBadge(
                                label: listing.category,
                                color: AppColors.primary),
                            const SizedBox(width: 6),
                            SmallBadge(
                              label: listing.condition,
                              color: listing.condition == 'New'
                                  ? AppColors.success
                                  : AppColors.warning,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Price + remove
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currencyFormat.format(listing.price),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Tooltip(
                        message: 'Remove item from cart',
                        child: InkWell(
                          onTap: () => context
                              .read<CartProvider>()
                              .removeItem(listing.listingId),
                          borderRadius: BorderRadius.circular(4),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.delete_outline,
                                color: AppColors.error, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  void _showPCBuildingGuide(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.build, color: AppColors.primary),
            SizedBox(width: 8),
            Text('PC Building Basics'),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GuideSection(
                title: '🔧 Picking the Right Parts',
                points: [
                  'CPU: The "brain" of your PC - determines processing power',
                  'GPU: Handles graphics - crucial for gaming and design',
                  'Motherboard: Connects all components - must support your CPU',
                  'RAM: Memory for multitasking - 16GB is standard now',
                  'Storage: SSDs are faster than HDDs - get at least 500GB',
                  'Power Supply: Must handle total power draw + 20% headroom',
                ],
              ),
              const SizedBox(height: 16),
              GuideSection(
                title: '⚙️ Compatibility Checklist',
                points: [
                  '✓ CPU Socket matches Motherboard socket',
                  '✓ RAM type matches Motherboard (DDR4, DDR5)',
                  '✓ GPU fits in PCIe slot and case clearance',
                  '✓ Cooler fits in case height (usually 70mm max)',
                  '✓ Power supply has right connectors (24-pin, 8-pin)',
                  '✓ Form factor fits your case (ATX, Micro-ATX, ITX)',
                ],
              ),
              const SizedBox(height: 16),
              GuideSection(
                title: '💡 Pro Tips',
                points: [
                  'Buy from trusted sellers with good ratings',
                  'Check component reviews on YouTube before buying',
                  'Used parts are cheaper but inspect photos carefully',
                  'Build guides on YouTube can show assembly steps',
                  'Have a compatible power supply ready before building',
                ],
              ),
            ],
          ),
        ),
        actions: [
          Tooltip(
            message: 'Close this dialog',
            child: TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Got it!'),
            ),
          ),
        ],
      ),
    );
  }
}
