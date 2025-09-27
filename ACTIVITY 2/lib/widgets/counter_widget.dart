import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Task 3: StatefulWidget with counter functionality
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget>
    with TickerProviderStateMixin {
  int _counter = 150; // Starting with 150 happy clients
  late AnimationController _animationController;
  late AnimationController _faceAnimationController;

  @override
  void initState() {
    super.initState();
    // Initialize animation controllers
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _faceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _faceAnimationController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    // <CHANGE> Trigger happy face animation
    _faceAnimationController.forward().then((_) {
      _faceAnimationController.reverse();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFFFFAF0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Happy Clients', // <CHANGE> Changed to Happy Clients
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF8B4513).withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    '$_counter',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  )
                      .animate(key: ValueKey(_counter))
                      .scale(duration: 200.ms)
                      .then()
                      .scale(
                          begin: const Offset(1.2, 1.2),
                          end: const Offset(1.0, 1.0),
                          duration: 200.ms),
                  const SizedBox(width: 10),
                  // <CHANGE> Added animated happy face
                  AnimatedBuilder(
                    animation: _faceAnimationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_faceAnimationController.value * 0.5),
                        child: Text(
                          '😊',
                          style: TextStyle(
                            fontSize: 24 + (_faceAnimationController.value * 8),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD2B48C),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: _decrementCounter,
                  icon: const Icon(Icons.remove, color: Colors.white),
                ),
              ),
              const SizedBox(width: 15),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _incrementCounter,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
