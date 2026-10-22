// Extracted FCM sender snippet from the report.
// The report notes this should be moved server-side in production.
class FcmSender {
  FcmSender._internal();

  static final FcmSender instance = FcmSender._internal();
  static const _projectId = 'food-ordering-app-5c822';
  static const _scopes = [
    'https://www.googleapis.com/auth/firebase.messaging'
  ];

  auth.AutoRefreshingAuthClient? _client;

  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    try {
      final client = await _getClient();
      final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send',
      );

      final payload = {
        'message': {
          'token': token,
          'notification': {'title': title, 'body': body},
        }
      };

      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode != 200) {
        print('FCM push failed: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('FCM push error: $e');
    }
  }
}
