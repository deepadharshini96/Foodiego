// Extracted order-saving snippet from the report.
Future<String?> _saveOrderToFirebase() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null || _cart.items.isEmpty) return null;

  final ref = _ordersRef('orders/${user.uid}').push();
  await ref.set({
    'restaurantName': _cart.items.first.restaurantName,
    'deliveryAddress': _addressController.text.trim(),
    'subtotal': subtotal,
    'deliveryFee': _deliveryFee,
    'tax': tax,
    'total': _grandTotal,
    'status': 'Placed',
    'placedAt': DateTime.now().toIso8601String(),
  });

  _sendOrderPlacedNotification(
    restaurantName: _cart.items.first.restaurantName,
  );
  return ref.key;
}
