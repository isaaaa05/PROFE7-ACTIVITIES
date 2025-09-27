class BookingService {
  static final BookingService _instance = BookingService._internal();
  factory BookingService() => _instance;
  BookingService._internal();

  List<BookingRequest> _bookings = [];
  List<String> _favoriteServices = [];

  List<BookingRequest> get bookings => _bookings;
  List<String> get favoriteServices => _favoriteServices;
  int get bookingCount => _bookings.length;

  void addBooking(BookingRequest booking) {
    _bookings.add(booking);
  }

  void removeBooking(String bookingId) {
    _bookings.removeWhere((booking) => booking.id == bookingId);
  }

  void toggleFavorite(String serviceId) {
    if (_favoriteServices.contains(serviceId)) {
      _favoriteServices.remove(serviceId);
    } else {
      _favoriteServices.add(serviceId);
    }
  }

  bool isFavorite(String serviceId) {
    return _favoriteServices.contains(serviceId);
  }

  void clearBookings() {
    _bookings.clear();
  }
}

class BookingRequest {
  final String id;
  final String serviceTitle;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String eventDate;
  final String message;
  final DateTime createdAt;
  final BookingStatus status;

  BookingRequest({
    required this.id,
    required this.serviceTitle,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.eventDate,
    required this.message,
    required this.createdAt,
    this.status = BookingStatus.pending,
  });
}

enum BookingStatus { pending, confirmed, completed, cancelled }
