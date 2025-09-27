class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  int _itemCount = 0;

  int get itemCount => _itemCount;

  void addItem() {
    _itemCount++;
  }

  void removeItem() {
    if (_itemCount > 0) {
      _itemCount--;
    }
  }

  void clearCart() {
    _itemCount = 0;
  }
}
