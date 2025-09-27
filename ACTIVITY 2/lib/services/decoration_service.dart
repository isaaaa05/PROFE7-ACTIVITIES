import '../models/decoration_item.dart';

class DecorationService {
  static final DecorationService _instance = DecorationService._internal();
  factory DecorationService() => _instance;
  DecorationService._internal();

  List<DecorationItem> getAllItems() {
    return [
      DecorationItem(
        id: '1',
        name: 'Birthday Balloon Set',
        description: 'Colorful balloon arrangements with helium',
        price: 1499.99,
        imageUrl: 'assets/images/services/baby_shower.jpg',
        category: 'Birthday',
        features: ['Helium included', '20+ balloons', 'Custom colors'],
      ),
      DecorationItem(
        id: '2',
        name: 'Wedding Centerpiece',
        description: 'Elegant floral centerpieces with candles',
        price: 4499.99,
        imageUrl: 'assets/images/services/floral_design.jpg',
        category: 'Wedding',
        features: ['Fresh flowers', 'LED candles', 'Custom arrangement'],
      ),
      DecorationItem(
        id: '3',
        name: 'Party String Lights',
        description: 'Warm LED string lights for ambiance',
        price: 2299.99,
        imageUrl: 'assets/images/services/string_lights.jpg',
        category: 'Lighting',
        features: ['50ft length', 'Warm white LEDs', 'Weather resistant'],
      ),
      DecorationItem(
        id: '4',
        name: 'Corporate Backdrop',
        description: 'Professional backdrop with logo placement',
        price: 9999.99,
        imageUrl: 'assets/images/services/corporate_backdrop.jpg',
        category: 'Corporate',
        features: ['Custom branding', '8x10 ft size', 'Professional setup'],
      ),
    ];
  }

  List<ServiceItem> getAllServices() {
    return [
      ServiceItem(
        id: '1',
        title: 'Complete Event Planning',
        description:
            'Full-service event planning and coordination from start to finish',
        price: 'From ₱25,000',
        duration: '4-8 hours',
        serviceType:
            'Birthday', // Fixed service types to match filter categories
        imageUrl: 'assets/images/services/event_planning.jpg',
        includes: [
          'Venue coordination',
          'Timeline management',
          'Vendor coordination',
          'Day-of coordination'
        ],
      ),
      ServiceItem(
        id: '2',
        title: 'Decoration Setup & Styling',
        description:
            'Professional decoration installation and styling services',
        price: 'From ₱10,000',
        duration: '2-4 hours',
        serviceType:
            'Wedding', // Fixed service types to match filter categories
        imageUrl: 'assets/images/services/wedding_arch.jpg',
        includes: [
          'Setup & breakdown',
          'Professional styling',
          'Custom arrangements',
          'Photo-ready finish'
        ],
      ),
      ServiceItem(
        id: '3',
        title: 'Custom Floral Design',
        description: 'Bespoke floral arrangements and centerpieces',
        price: 'From ₱7,500',
        duration: '1-2 hours',
        serviceType:
            'Corporate', // Fixed service types to match filter categories
        imageUrl: 'assets/images/services/floral_design.jpg',
        includes: [
          'Fresh flowers',
          'Custom design',
          'Delivery included',
          'Seasonal options'
        ],
      ),
      ServiceItem(
        id: '4',
        title: 'Lighting & Ambiance',
        description:
            'Professional lighting design and ambient atmosphere creation',
        price: 'From ₱9,000',
        duration: '2-3 hours',
        serviceType: 'Party', // Fixed service types to match filter categories
        imageUrl: 'assets/images/services/string_lights.jpg',
        includes: [
          'LED lighting',
          'Mood lighting',
          'String lights',
          'Professional setup'
        ],
      ),
      ServiceItem(
        id: '5',
        title: 'Birthday Party Package',
        description:
            'Complete birthday celebration setup with balloons and decorations',
        price: 'From ₱8,500',
        duration: '3-4 hours',
        serviceType: 'Birthday',
        imageUrl: 'assets/images/services/event_planning.jpg',
        includes: [
          'Balloon arrangements',
          'Birthday banners',
          'Table decorations',
          'Photo booth setup'
        ],
      ),
      ServiceItem(
        id: '6',
        title: 'Wedding Reception Decor',
        description: 'Elegant wedding reception decoration and styling',
        price: 'From ₱35,000',
        duration: '6-8 hours',
        serviceType: 'Wedding',
        imageUrl: 'assets/images/services/floral_design.jpg',
        includes: [
          'Bridal table setup',
          'Centerpieces',
          'Aisle decoration',
          'Reception styling'
        ],
      ),
    ];
  }

  List<DecorationItem> getItemsByCategory(String category) {
    if (category == 'All') return getAllItems();
    return getAllItems().where((item) => item.category == category).toList();
  }
}
