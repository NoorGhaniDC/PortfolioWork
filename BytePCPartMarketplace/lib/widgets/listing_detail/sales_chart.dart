import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../../core/constants/app_colors.dart';

class SalesPriceData {
  final DateTime date;
  final double price;

  SalesPriceData({required this.date, required this.price});
}

class SalesChart extends StatelessWidget {
  final String listingId;

  const SalesChart({
    Key? key,
    required this.listingId,
  }) : super(key: key);

  // Generate mock sales data for the component
  List<SalesPriceData> _generateMockSalesData() {
    final now = DateTime.now();
    final random = Random();
    final minPrice = 29.99;
    final maxPrice = 1999.99;

    return List.generate(8, (index) {
      // Generate random price between minPrice and maxPrice
      final randomPrice =
          minPrice + (random.nextDouble() * (maxPrice - minPrice));
      // Round to 2 decimal places
      final roundedPrice = (randomPrice * 100).round() / 100;

      return SalesPriceData(
        date: now.subtract(Duration(days: 90 - (index * 13))),
        price: roundedPrice,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final salesData = _generateMockSalesData();

    // Find min and max prices
    final prices = salesData.map((e) => e.price).toList();
    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    final priceRange = maxPrice - minPrice;

    // Find lowest and highest sold prices
    final lowestPrice = prices.reduce((a, b) => a < b ? a : b);
    final highestPrice = prices.reduce((a, b) => a > b ? a : b);

    final currencyFormat = NumberFormat('\$#,##0.00', 'en_US');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 16),

        // Section Title
        const Text(
          'Sales History',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),

        // Price Stats
        Row(
          children: [
            Expanded(
              child: _buildPriceStat(
                label: 'Lowest Sold',
                price: currencyFormat.format(lowestPrice),
                icon: Icons.trending_down,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPriceStat(
                label: 'Highest Sold',
                price: currencyFormat.format(highestPrice),
                icon: Icons.trending_up,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Mini Chart
        const Text(
          'Price Trend (Last 90 Days)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),

        // Chart visualization using bars
        SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(salesData.length, (index) {
              final data = salesData[index];
              final normalizedHeight = priceRange > 0
                  ? ((data.price - minPrice) / priceRange * 100)
                      .clamp(10.0, 100.0)
                  : 50.0;

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Bar
                  Container(
                    width: 20,
                    height: normalizedHeight,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.7),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Label (every other one to avoid crowding)
                  if (index % 2 == 0)
                    SizedBox(
                      width: 40,
                      child: Text(
                        DateFormat('M/d').format(data.date),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 40, height: 14),
                ],
              );
            }),
          ),
        ),
        const SizedBox(height: 16),

        // Sales Data Table
        const Text(
          'Recent Sales',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          salesData.length,
          (index) {
            final data = salesData[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: index == 0
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: index == 0
                      ? Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2))
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('MMM d, yyyy').format(data.date),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          index == 0 ? 'Most Recent' : '',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      currencyFormat.format(data.price),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPriceStat({
    required String label,
    required String price,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
