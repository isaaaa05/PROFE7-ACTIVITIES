import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/image_card.dart';
import '../models/decoration_item.dart';
import '../services/decoration_service.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DecorationService decorationService = DecorationService();
    final List<ServiceItem> services = decorationService.getAllServices();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 30),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return _buildServiceCard(context, services[index], index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Services',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B4513),
          ),
        ).animate().fadeIn(duration: 600.ms),
        const SizedBox(height: 10),
        Text(
          'Professional party decoration services tailored to make your celebrations unforgettable',
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xFF8B4513).withValues(alpha: 0.7),
            height: 1.5,
          ),
        ).animate().slideY(begin: 0.3, duration: 800.ms),
      ],
    );
  }

  Widget _buildServiceCard(
      BuildContext context, ServiceItem service, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Added service type label overlay on image
          Stack(
            children: [
              ImageCard(
                imageUrl: service.imageUrl,
                height: 150,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              Positioned(
                top: 15,
                left: 15,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    service.serviceType,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        service.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD2B48C).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        service.duration,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8B4513),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  service.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF8B4513).withValues(alpha: 0.7),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Includes:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B4513),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: service.includes.map((include) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5DC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF8B4513).withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        include,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8B4513),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        service.price,
                        style: const TextStyle(
                          fontSize: 18, // Reduced font size to prevent overflow
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10), // Added spacing
                    Flexible(
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8), // Reduced padding
                        color: const Color(0xFF8B4513),
                        borderRadius: BorderRadius.circular(15),
                        onPressed: () => _showBookingModal(context, service),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.arrow_right,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideX(begin: 0.3, duration: 600.ms, delay: (index * 100).ms);
  }

  // Added missing _showBookingModal method
  void _showBookingModal(BuildContext context, ServiceItem service) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5DC),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Modal Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Book ${service.title}',
                      style: const TextStyle(
                        fontSize: 20, // Reduced font size
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B4513),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Color(0xFF8B4513)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Service Info
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD2B48C),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.design_services,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B4513),
                            ),
                          ),
                          Text(
                            '${service.price} • ${service.duration}',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF8B4513)
                                  .withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Booking Form
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booking Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513),
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildTextField(
                          'Full Name *', nameController, Icons.person),
                      const SizedBox(height: 15),
                      _buildTextField(
                          'Email Address *', emailController, Icons.email),
                      const SizedBox(height: 15),
                      _buildTextField(
                          'Phone Number *', phoneController, Icons.phone),
                      const SizedBox(height: 15),
                      _buildTextField(
                          'Event Date *', dateController, Icons.calendar_today),
                      const SizedBox(height: 15),
                      _buildTextField('Additional Message', messageController,
                          Icons.message,
                          maxLines: 3),

                      const SizedBox(height: 30),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Booking request submitted successfully!'),
                                backgroundColor: Color(0xFF8B4513),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B4513),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Submit Booking Request',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Added missing _buildTextField helper method
  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              TextStyle(color: const Color(0xFF8B4513).withValues(alpha: 0.7)),
          prefixIcon: Icon(icon, color: const Color(0xFF8B4513)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
