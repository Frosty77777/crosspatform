import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../models/order.dart';
import '../state/app_state_scope.dart';

class CheckoutSheet extends StatefulWidget {
  const CheckoutSheet({super.key});

  static Future<void> show(BuildContext context) {
    final appState = AppStateScope.of(context);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          AppStateScope(state: appState, child: const CheckoutSheet()),
    );
  }

  @override
  State<CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends State<CheckoutSheet> {
  FulfillmentType _fulfillment = FulfillmentType.pickup;
  final _addressController = TextEditingController();
  final _recipientController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _addressController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  DateTime? get _dateTime {
    if (_selectedDate == null || _selectedTime == null) return null;
    return DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => _selectedTime = time);
  }

  void _submitOrder() {
    final app = AppStateScope.of(context);
    final cart = app.cart;

    final address = _addressController.text.trim();
    final needsAddress = _fulfillment == FulfillmentType.delivery;
    if (cart.isEmpty ||
        _recipientController.text.trim().isEmpty ||
        _dateTime == null ||
        (needsAddress && address.isEmpty)) {
      return;
    }

    HapticFeedback.mediumImpact();
    final first = cart.entries.first;
    app.orders.addOrder(
      Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        restaurantId: first.restaurantId,
        restaurantName: first.restaurantName,
        recipientName: _recipientController.text.trim(),
        fulfillment: _fulfillment,
        dateTime: _dateTime!,
        createdAt: DateTime.now(),
        deliveryAddress: needsAddress ? address : null,
        items: cart.entries
            .map((e) => OrderItem(item: e.item, quantity: e.quantity))
            .toList(),
      ),
    );

    cart.clear();
    Navigator.pop(context);
    context.go('/orders');
  }

  @override
  Widget build(BuildContext context) {
    final cart = AppStateScope.of(context).cart;
    return AnimatedBuilder(
      animation: cart,
      builder: (context, _) {
        final entries = cart.entries;
        final requiresAddress = _fulfillment == FulfillmentType.delivery;
        final hasAddress = _addressController.text.trim().isNotEmpty;
        final canSubmit =
            entries.isNotEmpty &&
            _recipientController.text.trim().isNotEmpty &&
            (!requiresAddress || hasAddress) &&
            _dateTime != null;

        return DraggableScrollableSheet(
          initialChildSize: 0.86,
          minChildSize: 0.45,
          maxChildSize: 0.96,
          builder: (context, controller) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  'Checkout',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                SegmentedButton<FulfillmentType>(
                  segments: const [
                    ButtonSegment(
                      value: FulfillmentType.pickup,
                      label: Text('Pick up'),
                      icon: Icon(Icons.storefront_outlined),
                    ),
                    ButtonSegment(
                      value: FulfillmentType.delivery,
                      label: Text('Delivery'),
                      icon: Icon(Icons.local_shipping_outlined),
                    ),
                  ],
                  selected: {_fulfillment},
                  onSelectionChanged: (set) => setState(() {
                    _fulfillment = set.first;
                    if (_fulfillment == FulfillmentType.pickup) {
                      _addressController.clear();
                    }
                  }),
                ),
                const SizedBox(height: 12),
                if (requiresAddress) ...[
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Enter delivery address',
                      hintText: 'Enter delivery address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                ],
                TextField(
                  controller: _recipientController,
                  decoration: const InputDecoration(
                    labelText: 'Recipient name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickDate,
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                        ),
                        label: Text(
                          _selectedDate == null
                              ? 'Select date'
                              : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickTime,
                        icon: const Icon(Icons.access_time_outlined, size: 18),
                        label: Text(
                          _selectedTime == null
                              ? 'Select time'
                              : _selectedTime!.format(context),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Cart items',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                if (entries.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: Lottie.asset(
                            'assets/animations/empty_cart.json',
                            repeat: true,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Your cart is empty.'),
                      ],
                    ),
                  )
                else
                  ...entries.map(
                    (e) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(e.item.name),
                        subtitle: Text(
                          '${e.rentalDays} day(s) · Insurance: ${e.withInsurance ? 'Yes' : 'No'} · Driver: ${e.withDriver ? 'Yes' : 'No'}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  cart.setQuantity(e.item, e.quantity - 1),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('${e.quantity}'),
                            IconButton(
                              onPressed: () =>
                                  cart.setQuantity(e.item, e.quantity + 1),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Total: \$${cart.totalPrice.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    FilledButton(
                      onPressed: canSubmit ? _submitOrder : null,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
