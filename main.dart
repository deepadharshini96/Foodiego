// Extracted Firebase initialization and app-routing snippets from the report.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  final token = await messaging.getToken();
  await _saveTokenForCurrentUser(token);

  FirebaseAuth.instance.authStateChanges().listen((user) async {
    final currentToken = await FirebaseMessaging.instance.getToken();
    await _saveTokenForCurrentUser(currentToken);

    if (user != null) {
      OrderStatusNotifier.instance.start();
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user != null && user.email == 'admin@gmail.com') {
            return const AdminHomePage();
          }
          return const CustomerHome();
        },
      ),
    );
  }
}
