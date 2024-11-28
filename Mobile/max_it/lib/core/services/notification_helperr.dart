// Simule une notification contenant un OTP
import 'package:awesome_notifications/awesome_notifications.dart';

void simulateOtpNotification() {
  const otp = '123456'; // Remplace par un OTP aléatoire
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'otp_channel',
      title: 'Votre code OTP',
      body: 'Votre code OTP est $otp',
    ),
  );
}

// Extrait le code OTP d'un message (par exemple, 6 chiffres consécutifs)
String? extractOtpFromMessage(String message) {
  final regex = RegExp(r'\b\d{6}\b');
  final match = regex.firstMatch(message);
  return match?.group(0);
}
