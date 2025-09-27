import 'package:flutter/material.dart';
import 'ordering_page.dart';
import 'reservation_page.dart';
import 'tracking_page.dart';
import 'feedback_form.dart';

class DashboardPage extends StatefulWidget {
  final String role;
  const DashboardPage({super.key, required this.role});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DashboardView(),
    const OrderingPage(),
    const ReservationPage(),
    const TrackingPage(),
  ];
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _signOut() {
    Navigator.pushReplacementNamed(context,
        '/splash'); // Navigate to splash screen, which will redirect to login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicketMaster Live Dashboard'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes back button
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut, // Sign-out action
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          _controller.reset();
          _controller.forward();
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), label: 'Reservations'),
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes), label: 'Tracking'),
        ],
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final role =
        (context.findAncestorWidgetOfExactType<DashboardPage>())?.role ??
            'Attendee';
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Icon(Icons.event_seat,
                      size: 40, color: Colors.deepPurple),
                  const SizedBox(height: 10),
                  Text('Welcome, $role!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Manage your events and tickets with ease.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: _statCard(
                      icon: Icons.event, title: 'Upcoming Events', value: '5')),
              const SizedBox(width: 8),
              Expanded(
                  child: _statCard(
                      icon: Icons.payment,
                      title: 'Total Spent',
                      value: '₱6000')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: _statCard(
                      icon: Icons.schedule, title: 'Reservations', value: '2')),
              const SizedBox(width: 8),
              Expanded(
                  child: _statCard(
                      icon: Icons.local_shipping,
                      title: 'Tickets Delivered',
                      value: '3')),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.2,
            children: [
              _featureCard(
                  icon: Icons.shopping_cart,
                  title: 'Buy Tickets',
                  description: 'Order tickets for events.',
                  onTap: () => Navigator.pushNamed(context, '/ordering')),
              _featureCard(
                  icon: Icons.schedule,
                  title: 'Reserve Seats',
                  description: 'Book pickup or premium slots.',
                  onTap: () => Navigator.pushNamed(context, '/reservation')),
              _featureCard(
                  icon: Icons.track_changes,
                  title: 'Track Tickets',
                  description: 'Monitor delivery status.',
                  onTap: () => Navigator.pushNamed(context, '/tracking')),
              _featureCard(
                  icon: Icons.feedback,
                  title: 'Give Feedback',
                  description: 'Share your experience.',
                  onTap: () => Navigator.pushNamed(context, '/feedback')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard(
      {required IconData icon, required String title, required String value}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.deepPurple),
            const SizedBox(height: 4),
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
            Text(value,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple)),
          ],
        ),
      ),
    );
  }

  Widget _featureCard(
      {required IconData icon,
      required String title,
      required String description,
      required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.deepPurple),
              const SizedBox(height: 4),
              Text(title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
