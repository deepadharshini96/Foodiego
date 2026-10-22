// Extracted CartModel snippet from the report.
class CartModel extends ChangeNotifier {
  static final CartModel instance = CartModel.internal();

  final Map<String, CartItem> _items = {};

  bool canAddFrom(String restaurantName) =>
      _items.isEmpty ||
      _items.values.first.restaurantName == restaurantName;

  void addItem({
    required String id,
    required String name,
    required double price,
    required String restaurantName,
  }) {
    final isNewItem = !_items.containsKey(id);

    if (!isNewItem) {
      _items[id]!.quantity++;
    } else {
      _items[id] = CartItem(
        id: id,
        name: name,
        price: price,
        restaurantName: restaurantName,
      );
    }

    notifyListeners();

    if (isNewItem) {
      _pushCartItemToFirebase(id: id, name: name, price: price);
      _sendCartNotification(itemName: name);
    }
  }
}
