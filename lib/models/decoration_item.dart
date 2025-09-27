// Model classes to structure our data
class DecorationItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> features;

  DecorationItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.features = const [],
  });
}

class ServiceItem {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  final String duration;
  final String serviceType; // <CHANGE> Added service type for labels
  final List<String> includes;

  ServiceItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.duration,
    required this.serviceType, // <CHANGE> Added service type
    this.includes = const [],
  });
}
