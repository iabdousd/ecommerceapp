import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {
  final _messaging = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    NotificationSettings settings = await _messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      settings = await _messaging.requestPermission();
    }
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        sound: true,
      );
      return await _messaging.getToken();
    }
    return null;
  }
}
