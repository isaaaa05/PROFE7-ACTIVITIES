// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'reservation_page.dart';
import 'ordering_page.dart';
import 'tracking_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    ReservationPage(),
    OrderingPage(),
    TrackingPage(),
  ];
  late AnimationController _controller;
  late Animation<double> _animation;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LogiTrack Home')),
      body: FadeTransition(
        opacity: _animation,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Reservation'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Ordering'),
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes), label: 'Tracking'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
