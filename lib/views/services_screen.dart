import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/image_card.dart';
import '../models/decoration_item.dart';
import '../services/decoration_service.dart';
import 'package:flutter/services.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String selectedFilter = 'All';
  final List<String> filterOptions = [
    'All',
    'Birthday',
    'Wedding',
    'Corporate',
    'Party'
  ];

  @override
  Widget build(BuildContext context) {
    final DecorationService decorationService = DecorationService();
    final List<ServiceItem> allServices = decorationService.getAllServices();

    final List<ServiceItem> filteredServices = selectedFilter == 'All'
        ? allServices
        : allServices
            .where((service) => service.serviceType
                .toLowerCase()
                .contains(selectedFilter.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC), // Fixed to beige background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 25),
                _buildServiceNavigation(),
                const SizedBox(height: 25),
                if (selectedFilter != 'All')
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      'Showing ${filteredServices.length} ${selectedFilter.toLowerCase()} services',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF8B4513).withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredServices.length,
                  itemBuilder: (context, index) {
                    return _buildServiceCard(
                        context, filteredServices[index], index);
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
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B4513), // Fixed to beige theme
          ),
        ).animate().fadeIn(duration: 600.ms),
        const SizedBox(height: 8),
        Text(
          'Professional decoration services for every celebration',
          style: TextStyle(
            fontSize: 15,
            color: const Color(0xFF8B4513)
                .withValues(alpha: 0.7), // Fixed to beige theme
            height: 1.4,
          ),
        ).animate().slideY(begin: 0.3, duration: 800.ms),
      ],
    );
  }

  // Activity 2 #6: Navigation bar using Row with icons spaced evenly
  Widget _buildServiceNavigation() {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.apps, 'All', selectedFilter == 'All'),
          _buildNavItem(
              Icons.cake_outlined, 'Birthday', selectedFilter == 'Birthday'),
          _buildNavItem(
              Icons.favorite_outline, 'Wedding', selectedFilter == 'Wedding'),
          _buildNavItem(Icons.business_outlined, 'Corporate',
              selectedFilter == 'Corporate'),
          _buildNavItem(
              Icons.celebration_outlined, 'Party', selectedFilter == 'Party'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
        HapticFeedback.selectionClick();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFD2B48C) // Fixed to beige
                  : const Color(0xFFD2B48C)
                      .withValues(alpha: 0.1), // Fixed to beige
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : const Color(0xFFD2B48C), // Fixed to beige
              size: 20,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? const Color(0xFFD2B48C) // Fixed to beige
                  : const Color(0xFF8B4513)
                      .withValues(alpha: 0.7), // Fixed to beige theme
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, ServiceItem service, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    service.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                        child: const Icon(
                          Icons.image,
                          color: Color(0xFF2E7D32),
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD2B48C), // Fixed to beige
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    service.serviceType,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18),
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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513), // Fixed to beige theme
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD2B48C)
                            .withValues(alpha: 0.1), // Fixed to beige
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        service.duration,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8B4513), // Fixed to beige theme
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
                    fontSize: 13,
                    color: const Color(0xFF8B4513)
                        .withValues(alpha: 0.7), // Fixed to beige theme
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: service.includes.take(3).map((include) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF0E6), // Fixed to beige
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFD2B48C)
                              .withValues(alpha: 0.2), // Fixed to beige
                        ),
                      ),
                      child: Text(
                        include,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF8B4513), // Fixed to beige theme
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      service.price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B4513), // Fixed to beige theme
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _showBookingModal(context, service),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFD2B48C), // Fixed to beige
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Book ${service.title}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B4513), // Fixed to beige theme
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close,
                        color: Color(0xFF8B4513)), // Fixed to beige theme
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextField(
                          'Full Name', nameController, Icons.person_outline),
                      const SizedBox(height: 12),
                      _buildTextField(
                          'Email', emailController, Icons.email_outlined),
                      const SizedBox(height: 12),
                      _buildTextField(
                          'Phone', phoneController, Icons.phone_outlined),
                      const SizedBox(height: 12),
                      _buildTextField('Event Date', dateController,
                          Icons.calendar_today_outlined),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Booking request submitted!'),
                                backgroundColor: Color(0xFF2E7D32),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFD2B48C), // Fixed to beige
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Submit Request',
                            style: TextStyle(color: Colors.white, fontSize: 15),
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

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF0E6), // Fixed to beige
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFFD2B48C)
                .withValues(alpha: 0.2)), // Fixed to beige
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              color: const Color(0xFF8B4513)
                  .withValues(alpha: 0.7)), // Fixed to beige theme
          prefixIcon: Icon(icon,
              color: const Color(0xFFD2B48C), size: 20), // Fixed to beige
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
