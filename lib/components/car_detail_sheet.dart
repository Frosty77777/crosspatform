import 'package:flutter/material.dart';
import '../models/restaurant.dart';

/// Full-detail bottom sheet for a single rental car.
/// Shows image, specs, characteristics and a Book Now button.
class CarDetailSheet extends StatefulWidget {
  final Item item;
  const CarDetailSheet({super.key, required this.item});

  static void show(BuildContext context, Item item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CarDetailSheet(item: item),
    );
  }

  @override
  State<CarDetailSheet> createState() => _CarDetailSheetState();
}

class _CarDetailSheetState extends State<CarDetailSheet> {
  int _rentalDays = 1;
  bool _withInsurance = false;
  bool _withDriver = false;
  bool _isFavorited = false;

  double get _total =>
      widget.item.price * _rentalDays + (_withInsurance ? 15 * _rentalDays : 0) + (_withDriver ? 40 * _rentalDays : 0);

  // Derive simple specs from the item name so no model changes are needed
  Map<String, String> get _specs {
    final name = widget.item.name.toLowerCase();
    if (name.contains('tesla') || name.contains('electric')) {
      return {
        'Type': 'Electric sedan',
        'Range': '560 km',
        'Seats': '5',
        'Transmission': 'Automatic',
        'Fuel': 'Electric',
        'Top speed': '250 km/h',
      };
    } else if (name.contains('bmw') || name.contains('x5')) {
      return {
        'Type': 'Luxury SUV',
        'Engine': '3.0L Turbo',
        'Seats': '5',
        'Transmission': 'Automatic',
        'Fuel': 'Petrol',
        'Top speed': '240 km/h',
      };
    } else if (name.contains('mustang')) {
      return {
        'Type': 'Sport coupe',
        'Engine': '5.0L V8',
        'Seats': '4',
        'Transmission': 'Manual',
        'Fuel': 'Petrol',
        'Top speed': '270 km/h',
      };
    } else if (name.contains('tucson') || name.contains('suv')) {
      return {
        'Type': 'Family SUV',
        'Engine': '2.0L',
        'Seats': '5',
        'Transmission': 'Automatic',
        'Fuel': 'Petrol',
        'Top speed': '185 km/h',
      };
    } else {
      return {
        'Type': 'Compact sedan',
        'Engine': '1.8L',
        'Seats': '5',
        'Transmission': 'Automatic',
        'Fuel': 'Petrol',
        'Top speed': '195 km/h',
      };
    }
  }

  void _confirmBooking() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Text('Booking confirmed!'),
        ]),
        content: Text(
          'You booked the ${widget.item.name} for $_rentalDays day(s).\n'
          'Total: \$${_total.toStringAsFixed(0)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          children: [
            // ── drag handle ────────────────────────────────────────────
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // ── image ──────────────────────────────────────────────────
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      widget.item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: cs.surfaceContainerLow,
                        child: const Icon(Icons.directions_car, size: 64),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => setState(() => _isFavorited = !_isFavorited),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── name + price ───────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(widget.item.name,
                      style: tt.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${widget.item.price.toStringAsFixed(0)}',
                      style: tt.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700, color: cs.primary),
                    ),
                    Text('per day', style: tt.labelSmall),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(widget.item.description, style: tt.bodyMedium),
            const SizedBox(height: 20),

            // ── characteristics grid ───────────────────────────────────
            Text('Characteristics',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.4,
              children: _specs.entries
                  .map((e) => _SpecCard(label: e.key, value: e.value))
                  .toList(),
            ),
            const SizedBox(height: 24),

            // ── rental days picker ─────────────────────────────────────
            Text('Rental duration',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Row(children: [
              IconButton.outlined(
                onPressed: _rentalDays > 1
                    ? () => setState(() => _rentalDays--)
                    : null,
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 12),
              Text('$_rentalDays day${_rentalDays > 1 ? 's' : ''}',
                  style: tt.titleMedium),
              const SizedBox(width: 12),
              IconButton.outlined(
                onPressed: _rentalDays < 30
                    ? () => setState(() => _rentalDays++)
                    : null,
                icon: const Icon(Icons.add),
              ),
            ]),
            const SizedBox(height: 20),

            // ── add-ons ────────────────────────────────────────────────
            Text('Add-ons',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            _AddonTile(
              icon: Icons.shield_outlined,
              title: 'Full insurance',
              subtitle: '+\$15/day',
              value: _withInsurance,
              onChanged: (v) => setState(() => _withInsurance = v),
            ),
            _AddonTile(
              icon: Icons.person_outline,
              title: 'Personal driver',
              subtitle: '+\$40/day',
              value: _withDriver,
              onChanged: (v) => setState(() => _withDriver = v),
            ),
            const SizedBox(height: 24),

            // ── total + book button ────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total',
                            style: tt.labelMedium
                                ?.copyWith(color: cs.onPrimaryContainer)),
                        Text(
                          '\$${_total.toStringAsFixed(0)}',
                          style: tt.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: cs.onPrimaryContainer),
                        ),
                        Text(
                          'for $_rentalDays day${_rentalDays > 1 ? 's' : ''}',
                          style: tt.labelSmall
                              ?.copyWith(color: cs.onPrimaryContainer),
                        ),
                      ],
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _confirmBooking,
                    icon: const Icon(Icons.directions_car),
                    label: const Text('Book Now'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── small spec card ──────────────────────────────────────────────────────────
class _SpecCard extends StatelessWidget {
  final String label;
  final String value;
  const _SpecCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// ── add-on toggle row ────────────────────────────────────────────────────────
class _AddonTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _AddonTile(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}
