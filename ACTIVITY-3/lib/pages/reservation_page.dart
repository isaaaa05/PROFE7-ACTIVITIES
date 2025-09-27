import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'payment_page.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _agreeTerms = false;
  bool _vipUpgrade = false;
  final TextEditingController _nameController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _submit() {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedTime != null &&
        _agreeTerms) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PaymentPage(amount: _vipUpgrade ? 500.0 : 0.0)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please complete all fields and agree to terms')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reserve Your Spot')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Icon(Icons.event_seat,
                        size: 80, color: Colors.deepPurple),
                    const SizedBox(height: 20),
                    const Text('Reserve Your Spot',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Your Name',
                        prefixIcon:
                            Icon(Icons.person, color: Colors.deepPurple),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Name required' : null,
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Select Date',
                          prefixIcon:
                              Icon(Icons.date_range, color: Colors.deepPurple),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        child: Text(_selectedDate == null
                            ? 'No date chosen'
                            : DateFormat('yyyy-MM-dd').format(_selectedDate!)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: _pickTime,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Select Time',
                          prefixIcon:
                              Icon(Icons.access_time, color: Colors.deepPurple),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        child: Text(_selectedTime == null
                            ? 'No time chosen'
                            : _selectedTime!.format(context)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CheckboxListTile(
                      title: const Text('Agree to terms & conditions'),
                      value: _agreeTerms,
                      onChanged: (val) => setState(() => _agreeTerms = val!),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.deepPurple,
                    ),
                    const SizedBox(height: 20),
                    SwitchListTile(
                      title: const Text('VIP Upgrade (+₱500)'),
                      subtitle: const Text('Front-row access & perks'),
                      value: _vipUpgrade,
                      onChanged: (val) => setState(() => _vipUpgrade = val!),
                      activeColor: Colors.deepPurple,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 30),
                    SlideTransition(
                      position: _slideAnimation,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple),
                          child: const Text('Reserve Now',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.status != AnimationStatus.completed) {
      _controller.forward();
    }
  }
}
