import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import 'car_detail_sheet.dart';

class RestaurantItem extends StatelessWidget {
  final Item item;
  final void Function(int rentalDays, bool withInsurance, bool withDriver, double total)? onBook;

  const RestaurantItem({super.key, required this.item, this.onBook});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Wrap the whole card in InkWell so tapping anywhere opens the detail sheet
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => CarDetailSheet.show(context, item, onBook: onBook),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildListItem()),
            _buildImageStack(colorScheme, context),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem() {
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      title: Text(item.name),
      subtitle: _buildSubtitle(),
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDescription(),
        const SizedBox(height: 4),
        _buildPriceAndLikes(),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      item.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPriceAndLikes() {
    return Row(
      children: [
        Text('\$${item.price.toStringAsFixed(0)}/day'),
        const SizedBox(width: 4),
        const Icon(Icons.thumb_up, color: Colors.green, size: 18),
      ],
    );
  }

  Widget _buildImageStack(ColorScheme colorScheme, BuildContext context) {
    return Stack(
      children: [
        _buildImage(),
        _buildBookButton(colorScheme, context),
      ],
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.shade200,
              child: const Icon(Icons.directions_car),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookButton(ColorScheme colorScheme, BuildContext context) {
    return Positioned(
      bottom: 8.0,
      right: 8.0,
      child: GestureDetector(
        onTap: () => CarDetailSheet.show(context, item, onBook: onBook),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            'Book',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
