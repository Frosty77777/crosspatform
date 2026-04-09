import 'package:flutter/material.dart';

/// Chapter 7 — Interactive Widgets demo page
/// Showcases: BottomSheet, GestureDetector, DatePicker,
/// TimePicker, Switch, Radio, Checkbox, FilterChip, Dismissible
class Chapter7WidgetsPage extends StatefulWidget {
  const Chapter7WidgetsPage({super.key});

  @override
  State<Chapter7WidgetsPage> createState() => _Chapter7WidgetsPageState();
}

class _Chapter7WidgetsPageState extends State<Chapter7WidgetsPage> {
  // ── state ──────────────────────────────────────────────────────────────────
  String _gestureResult = 'Waiting for gesture…';
  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;
  bool _insuranceEnabled = false;
  String _selectedClass = 'Economy';
  bool _fullTankChecked = false;
  bool _childSeatChecked = false;
  final Set<String> _selectedCategories = {'Sedan'};
  final List<_BookingItem> _bookings = [
    _BookingItem(id: '1', title: 'Tesla Model 3 — Apr 12', sub: 'cashauto rent'),
    _BookingItem(id: '2', title: 'Honda Civic — Apr 18', sub: 'Urban Auto'),
    _BookingItem(id: '3', title: 'BMW X5 — Apr 25', sub: 'cashauto rent'),
  ];

  // ── Bottom Sheet ───────────────────────────────────────────────────────────
  void _showBookingBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text('Book a Car',
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('Choose your pick-up date and confirm the rental.',
                style: Theme.of(ctx).textTheme.bodyMedium),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Confirm'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // ── Date & Time Picker ─────────────────────────────────────────────────────
  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null) setState(() => _pickedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => _pickedTime = time);
  }

  // ── helpers ────────────────────────────────────────────────────────────────
  String _formatDate(DateTime d) =>
      '${d.day} ${_months[d.month - 1]} ${d.year}';
  static const _months = [
    'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
  ];

  // ── build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chapter 7 — Widgets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionHeader('1 · Bottom Sheet'),
          _DemoCard(
            child: ElevatedButton.icon(
              onPressed: _showBookingBottomSheet,
              icon: const Icon(Icons.expand_less),
              label: const Text('Show booking sheet'),
            ),
          ),
          const SizedBox(height: 24),

          _SectionHeader('2 · Gesture Detector'),
          _DemoCard(
            child: Column(children: [
              GestureDetector(
                onTap: () => setState(() => _gestureResult = 'onTap fired ✓'),
                onLongPress: () =>
                    setState(() => _gestureResult = 'onLongPress fired ✓'),
                onHorizontalDragEnd: (d) => setState(() => _gestureResult =
                    (d.primaryVelocity ?? 0) > 0
                        ? 'Swiped right →'
                        : 'Swiped left ←'),
                onDoubleTap: () =>
                    setState(() => _gestureResult = 'onDoubleTap fired ✓'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Tap / long-press / swipe me'),
                ),
              ),
              const SizedBox(height: 12),
              Text(_gestureResult,
                  style: Theme.of(context).textTheme.bodySmall),
            ]),
          ),
          const SizedBox(height: 24),

          _SectionHeader('3 · Date & Time Picker'),
          _DemoCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Row(children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today, size: 16),
                    label: Text(_pickedDate == null
                        ? 'Pick-up date'
                        : _formatDate(_pickedDate!)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickTime,
                    icon: const Icon(Icons.access_time, size: 16),
                    label: Text(_pickedTime == null
                        ? 'Pick-up time'
                        : _pickedTime!.format(context)),
                  ),
                ),
              ]),
            ]),
          ),
          const SizedBox(height: 24),

          _SectionHeader('4 · Input & Selection Widgets'),
          _DemoCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // TextFormField
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Driver name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),

              // Switch
              SwitchListTile(
                title: const Text('Include insurance'),
                subtitle: const Text('Full coverage plan'),
                value: _insuranceEnabled,
                onChanged: (v) => setState(() => _insuranceEnabled = v),
                contentPadding: EdgeInsets.zero,
              ),
              const Divider(),

              // Radio
              const Text('Rental class', style: TextStyle(fontWeight: FontWeight.w600)),
              for (final cls in ['Economy', 'Business', 'Luxury'])
                RadioListTile<String>(
                  title: Text(cls),
                  value: cls,
                  groupValue: _selectedClass,
                  onChanged: (v) => setState(() => _selectedClass = v!),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                ),
              const Divider(),

              // Checkbox
              const Text('Add-ons', style: TextStyle(fontWeight: FontWeight.w600)),
              CheckboxListTile(
                title: const Text('Full tank'),
                value: _fullTankChecked,
                onChanged: (v) => setState(() => _fullTankChecked = v!),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
              CheckboxListTile(
                title: const Text('Child seat'),
                value: _childSeatChecked,
                onChanged: (v) => setState(() => _childSeatChecked = v!),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
              const Divider(),

              // FilterChip
              const Text('Car category', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['Sedan', 'SUV', 'Luxury', 'Electric', 'Sport']
                    .map((cat) => FilterChip(
                          label: Text(cat),
                          selected: _selectedCategories.contains(cat),
                          onSelected: (sel) => setState(() => sel
                              ? _selectedCategories.add(cat)
                              : _selectedCategories.remove(cat)),
                        ))
                    .toList(),
              ),
            ]),
          ),
          const SizedBox(height: 24),

          _SectionHeader('5 · Dismissible'),
          ..._bookings.map(
            (booking) => Dismissible(
              key: ValueKey(booking.id),
              background: _DismissBackground(
                  color: Colors.red.shade100,
                  icon: Icons.delete_outline,
                  alignment: Alignment.centerLeft,
                  label: 'Delete'),
              secondaryBackground: _DismissBackground(
                  color: Colors.green.shade100,
                  icon: Icons.archive_outlined,
                  alignment: Alignment.centerRight,
                  label: 'Archive'),
              onDismissed: (direction) {
                setState(() => _bookings.remove(booking));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(direction == DismissDirection.startToEnd
                        ? '${booking.title} deleted'
                        : '${booking.title} archived'),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: const Icon(Icons.directions_car_outlined),
                  title: Text(booking.title),
                  subtitle: Text(booking.sub),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
          ),
          if (_bookings.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('All bookings dismissed!'),
              ),
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ── helpers ────────────────────────────────────────────────────────────────

class _BookingItem {
  final String id, title, sub;
  _BookingItem({required this.id, required this.title, required this.sub});
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700)),
      );
}

class _DemoCard extends StatelessWidget {
  final Widget child;
  const _DemoCard({required this.child});
  @override
  Widget build(BuildContext context) => Card(
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      );
}

class _DismissBackground extends StatelessWidget {
  final Color color;
  final IconData icon;
  final AlignmentGeometry alignment;
  final String label;
  const _DismissBackground(
      {required this.color,
      required this.icon,
      required this.alignment,
      required this.label});
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        alignment: alignment,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      );
}
