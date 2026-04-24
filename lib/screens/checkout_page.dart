import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/order.dart';
import '../state/app_state_scope.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  FulfillmentType _fulfillment = FulfillmentType.pickup;
  final _recipientController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _recipientController.dispose();
    super.dispose();
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

  void _submitOrder() {
    final app = AppStateScope.of(context);
    final cart = app.cart;
    final orders = app.orders;

    final dateTime = _dateTime;
    if (cart.isEmpty) return;
    if (_recipientController.text.trim().isEmpty) return;
    if (dateTime == null) return;

    final first = cart.entries.first;
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      restaurantId: first.restaurantId,
      restaurantName: first.restaurantName,
      recipientName: _recipientController.text.trim(),
      fulfillment: _fulfillment,
      dateTime: dateTime,
      createdAt: DateTime.now(),
      items: cart.entries
          .map((e) => OrderItem(item: e.item, quantity: e.quantity))
          .toList(),
    );

    orders.addOrder(order);
    cart.clear();

    // Redirect to Orders tab after submitting.
    context.go('/orders');
  }

  @override
  Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final cart = app.cart;

    return AnimatedBuilder(
      animation: cart,
      builder: (context, _) {
        final entries = cart.entries;
        final canSubmit = entries.isNotEmpty &&
            _recipientController.text.trim().isNotEmpty &&
            _dateTime != null;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Checkout'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Fulfillment',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
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
                onSelectionChanged: (set) =>
                    setState(() => _fulfillment = set.first),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _recipientController,
                decoration: const InputDecoration(
                  labelText: 'Recipient name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today_outlined, size: 18),
                      label: Text(
                        _selectedDate == null
                            ? 'Select date'
                            : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
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
              const SizedBox(height: 24),
              Text(
                'Cart',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              if (entries.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: Text('Your cart is empty.')),
                )
              else
                ...entries.map(
                  (e) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  FilledButton(
                    onPressed: canSubmit ? _submitOrder : null,
                    child: const Text('Submit order'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

