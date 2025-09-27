import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'payment_page.dart';

class OrderingPage extends StatefulWidget {
  const OrderingPage({super.key});

  @override
  State<OrderingPage> createState() => _OrderingPageState();
}

class _OrderingPageState extends State<OrderingPage> {
  final _formKey = GlobalKey<FormState>();
  final _eventController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _seatPreferenceController = TextEditingController();
  final _usernameController = TextEditingController(); // Reverted to Username
  String _eventType = 'Concert';
  DateTime? _selectedDate;
  bool _vipUpgrade = false;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final quantity = int.tryParse(_quantityController.text) ?? 1;
      final amount = (quantity * 500.0) + (_vipUpgrade ? 500.0 : 0.0);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            amount: amount,
            cart: [
              {
                'event': _eventController.text,
                'quantity': _quantityController.text,
                'type': _eventType,
                'date': _selectedDate.toString(),
                'seatPreference': _seatPreferenceController.text,
                'username': _usernameController.text, // Using username
                'email': 'user@example.com', // Placeholder
              }
            ],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')));
    }
  }

  @override
  void dispose() {
    _eventController.dispose();
    _quantityController.dispose();
    _seatPreferenceController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Tickets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ticket Order Form',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller:
                        _usernameController, // Username field for requirement #1
                    decoration: const InputDecoration(
                      labelText: 'Username *',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Username is required' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _eventController,
                    decoration: const InputDecoration(
                      labelText: 'Event Name *',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Event name is required' : null,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _eventType,
                    items: ['Concert', 'Sports', 'Theater', 'Festival']
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) => setState(() => _eventType = value!),
                    decoration: const InputDecoration(
                      labelText: 'Event Type *',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity *',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => int.tryParse(value ?? '') == null ||
                            int.parse(value!) < 1
                        ? 'Enter a valid quantity'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: _pickDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Event Date *',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                      child: Text(_selectedDate == null
                          ? 'Select Date'
                          : DateFormat('yyyy-MM-dd').format(_selectedDate!)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _seatPreferenceController,
                    decoration: const InputDecoration(
                      labelText: 'Seat Preference',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: const Text('VIP Upgrade (+₱500)'),
                    value: _vipUpgrade,
                    onChanged: (val) => setState(() => _vipUpgrade = val),
                    activeColor: Colors.deepPurple,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: const Size(double.infinity, 50)),
                    child: const Text('Proceed to Payment',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
