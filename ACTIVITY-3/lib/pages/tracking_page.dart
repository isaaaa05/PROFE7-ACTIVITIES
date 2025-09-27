import 'package:flutter/material.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '12345',
      'status': 'In Transit',
      'date': '2025-09-25',
      'progress': 0.6
    },
    {
      'id': '12346',
      'status': 'Delivered',
      'date': '2025-09-20',
      'progress': 1.0
    },
  ];
  bool _isLoading = false;

  Future<void> _refreshTracking() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    setState(() {
      _orders[0] = {
        'id': '12345',
        'status': 'Out for Delivery',
        'date': '2025-09-25',
        'progress': 0.8
      };
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Tickets'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Removes back button
      ),
      body: RefreshIndicator(
        onRefresh: _refreshTracking,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Track your ticket delivery status here.',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  final order = _orders[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.local_shipping,
                          color: Colors.deepPurple),
                      title: Text('Order #${order['id']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status: ${order['status']}'),
                          Text('Date: ${order['date']}'),
                        ],
                      ),
                      trailing: _isLoading && index == 0
                          ? const CircularProgressIndicator(
                              color: Colors.deepPurple)
                          : null,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const Center(
                    child: CircularProgressIndicator(color: Colors.deepPurple)),
            ],
          ),
        ),
      ),
    );
  }
}
