// Extracted live restaurant list snippet from the report.
class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin — Restaurants')),
      body: StreamBuilder<List<Restaurant>>(
        stream: RestaurantRepository.instance.watchRestaurants(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final restaurants = snapshot.data!;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(restaurants[i].name),
              subtitle: Text(restaurants[i].location),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AdminRestaurantEditPage(
                    restaurant: restaurants[i],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
