// Extracted order-status listener snippet from the report.
void start() {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  _ordersRef = _db.ref('orders/${user.uid}');
  _ordersRef!.onChildChanged.listen((event) {
    final orderId = event.snapshot.key;
    final data = event.snapshot.value;
    if (orderId == null || data is! Map) return;

    final newStatus = data['status']?.toString();
    final previousStatus = _lastKnownStatus[orderId];
    _lastKnownStatus[orderId] = newStatus!;

    if (previousStatus != null && previousStatus != newStatus) {
      _notify(newStatus);
    }
  });
}
