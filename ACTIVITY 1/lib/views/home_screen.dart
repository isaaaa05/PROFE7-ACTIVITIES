import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/counter_widget.dart';
import '../widgets/image_card.dart';
import '../widgets/custom_button.dart';
import '../models/decoration_item.dart';
import '../services/decoration_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  final DecorationService _decorationService = DecorationService();

  List<DecorationItem> get filteredItems {
    return _decorationService.getItemsByCategory(selectedCategory);
  }

  void _showFeatureModal(String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5DC),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          feature,
          style: const TextStyle(
              color: Color(0xFF8B4513), fontWeight: FontWeight.bold),
        ),
        content: Text(
          'This $feature feature is coming soon! Stay tuned for updates.',
          style:
              TextStyle(color: const Color(0xFF8B4513).withValues(alpha: 0.8)),
        ),
        actions: [
          CustomButton(
            text: 'Got it!',
            onPressed: () => Navigator.pop(context),
            isPrimary: true,
            width: 100,
          ),
        ],
      ),
    );
  }

  // <CHANGE> Added profile modal
  void _showProfileModal() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5DC),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B4513),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Color(0xFF8B4513)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD2B48C), Color(0xFF8B4513)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    CupertinoIcons.person_fill,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Party Glow User',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B4513),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'party.glow@email.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0xFF8B4513).withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView(
                    children: [
                      _buildProfileOption(Icons.person, 'Edit Profile'),
                      _buildProfileOption(Icons.favorite, 'My Favorites'),
                      _buildProfileOption(Icons.history, 'Order History'),
                      _buildProfileOption(Icons.notifications, 'Notifications'),
                      _buildProfileOption(Icons.help, 'Help & Support'),
                      _buildProfileOption(Icons.settings, 'Settings'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Sign Out',
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Signed out successfully!'),
                        backgroundColor: Color(0xFF8B4513),
                      ),
                    );
                  },
                  isPrimary: true,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8B4513)),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF8B4513),
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Color(0xFF8B4513), size: 16),
        onTap: () {
          Navigator.pop(context);
          _showFeatureModal(title);
        },
      ),
    );
  }

  // <CHANGE> Added quote modal
  void _showQuoteModal(DecorationItem item) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController eventDateController = TextEditingController();
    final TextEditingController guestCountController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5DC),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Get Quote for ${item.name}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Color(0xFF8B4513)),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
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
                          Icons.celebration,
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
                              item.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                            Text(
                              'Starting at ₱${item.price.toStringAsFixed(2)}',
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
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B4513),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildQuoteTextField(
                            'Full Name *', nameController, Icons.person),
                        const SizedBox(height: 15),
                        _buildQuoteTextField(
                            'Email Address *', emailController, Icons.email),
                        const SizedBox(height: 15),
                        _buildQuoteTextField(
                            'Phone Number *', phoneController, Icons.phone),
                        const SizedBox(height: 20),
                        const Text(
                          'Event Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B4513),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildQuoteTextField('Event Date *',
                            eventDateController, Icons.calendar_today),
                        const SizedBox(height: 15),
                        _buildQuoteTextField('Expected Guests *',
                            guestCountController, Icons.group),
                        const SizedBox(height: 15),
                        _buildQuoteTextField('Additional Requirements',
                            messageController, Icons.message,
                            maxLines: 3),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Cancel',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: 'Get Quote',
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Quote request submitted! We\'ll contact you soon.'),
                              backgroundColor: Color(0xFF8B4513),
                            ),
                          );
                        },
                        isPrimary: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteTextField(
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

  @override
  Widget build(BuildContext context) {
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
                const CounterWidget(),
                const SizedBox(height: 30),
                _buildSearchBar(),
                const SizedBox(height: 30),
                _buildCategories(),
                const SizedBox(height: 30),
                _buildFeaturedSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello! ✨',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF8B4513).withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Plan Your Perfect Party',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B4513),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _showProfileModal, // <CHANGE> Connected to profile modal
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFD2B48C), Color(0xFF8B4513)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              CupertinoIcons.person_fill,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search decorations...',
          hintStyle:
              TextStyle(color: const Color(0xFF8B4513).withValues(alpha: 0.5)),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF8B4513)),
          suffixIcon: IconButton(
            icon: Icon(Icons.tune,
                color: const Color(0xFF8B4513).withValues(alpha: 0.7)),
            onPressed: () => _showFeatureModal('Advanced Filters'),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    ).animate().slideX(begin: -0.3, duration: 800.ms);
  }

  Widget _buildCategories() {
    final categories = ['All', 'Birthday', 'Wedding', 'Corporate', 'Lighting'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B4513),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              String category = categories[index];
              bool isSelected = selectedCategory == category;
              return Container(
                margin: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? const Color(0xFF8B4513) : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF8B4513)
                            : const Color(0xFF8B4513).withValues(alpha: 0.3),
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF8B4513)
                                    .withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color:
                            isSelected ? Colors.white : const Color(0xFF8B4513),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ).animate().slideY(begin: 0.3, duration: 1000.ms);
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Featured Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B4513),
              ),
            ),
            TextButton(
              onPressed: () => _showFeatureModal('View All Items'),
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: filteredItems.map((item) {
            return _buildItemCard(item);
          }).toList(),
        ),
      ],
    ).animate().fadeIn(duration: 1200.ms);
  }

  Widget _buildItemCard(DecorationItem item) {
    return Container(
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
          ImageCard(
            imageUrl: item.imageUrl,
            height: 120,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B4513),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF8B4513).withValues(alpha: 0.7),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₱${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B4513),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showAddToCartModal(item),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B4513),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
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
    );
  }

  void _showAddToCartModal(DecorationItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5DC),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add ${item.name}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B4513),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Price: ₱${item.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF8B4513),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Add to Wishlist',
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.name} added to wishlist!'),
                          backgroundColor: const Color(0xFF8B4513),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: 'Get Quote',
                    onPressed: () {
                      Navigator.pop(context);
                      _showQuoteModal(
                          item); // <CHANGE> Connected to quote modal
                    },
                    isPrimary: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
