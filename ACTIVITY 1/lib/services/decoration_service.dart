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
        imageUrl: 'assets/images/balloons.jpg',
        category: 'Birthday',
        features: ['Helium included', '20+ balloons', 'Custom colors'],
      ),
      DecorationItem(
        id: '2',
        name: 'Wedding Centerpiece',
        description: 'Elegant floral centerpieces with candles',
        price: 4499.99,
        imageUrl: 'assets/images/wedding_centerpiece.jpg',
        category: 'Wedding',
        features: ['Fresh flowers', 'LED candles', 'Custom arrangement'],
      ),
      DecorationItem(
        id: '3',
        name: 'Party String Lights',
        description: 'Warm LED string lights for ambiance',
        price: 2299.99,
        imageUrl: 'assets/images/string_lights.jpg',
        category: 'Lighting',
        features: ['50ft length', 'Warm white LEDs', 'Weather resistant'],
      ),
      DecorationItem(
        id: '4',
        name: 'Corporate Backdrop',
        description: 'Professional backdrop with logo placement',
        price: 9999.99,
        imageUrl: 'assets/images/corporate_backdrop.jpg',
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
        serviceType: 'Premium Planning', // <CHANGE> Added service type labels
        imageUrl: 'assets/images/event_planning.jpg',
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
        serviceType: 'Setup Service', // <CHANGE> Added service type labels
        imageUrl: 'assets/images/corporate_backdrop.jpg',
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
        serviceType: 'Floral Design', // <CHANGE> Added service type labels
        imageUrl: 'assets/images/floral_design.jpg',
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
        serviceType: 'Lighting Service', // <CHANGE> Added service type labels
        imageUrl: 'assets/images/string_lights.jpg',
        includes: [
          'LED lighting',
          'Mood lighting',
          'String lights',
          'Professional setup'
        ],
      ),
    ];
  }

  List<DecorationItem> getItemsByCategory(String category) {
    if (category == 'All') return getAllItems();
    return getAllItems().where((item) => item.category == category).toList();
  }
}
