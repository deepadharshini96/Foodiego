// Extracted live restaurant stream snippet from the report.
Stream<List<Restaurant>> watchRestaurants() {
  return _ref.onValue.map((event) {
    final raw = event.snapshot.value;
    if (raw == null) return <Restaurant>[];

    final map = Map<dynamic, dynamic>.from(raw as Map);
    return map.entries
        .where((e) => e.value is Map)
        .map((e) => Restaurant.fromMap(
              e.key.toString(),
              Map<dynamic, dynamic>.from(e.value as Map),
            ))
        .toList();
  });
}
