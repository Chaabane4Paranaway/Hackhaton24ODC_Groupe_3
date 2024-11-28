import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:pinput/pinput.dart';

void main() {
  runApp(const MyApp());
  initializeNotifications();
}

void initializeNotifications() {
  AwesomeNotifications().initialize(
    null, // Icône par défaut
    [
      NotificationChannel(
        channelKey: 'otp_channel',
        channelName: 'OTP Notifications',
        channelDescription: 'Channel for OTP messages',
        defaultColor: Colors.blue,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );

  // Capture les interactions avec les notifications
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: onNotificationAction,
  );
}

Future<void> onNotificationAction(ReceivedAction action) async {
  if (action.channelKey == 'otp_channel' && action.body != null) {
    // Extrait le OTP et met à jour le contrôleur
    final otp = extractOtpFromMessage(action.body!);
    if (otp != null) {
      // Mise à jour du TextEditingController via une méthode globale
      OtpController.updateOtp(otp);
    }
  }
}

// Fonction pour extraire le code OTP du message
String? extractOtpFromMessage(String message) {
  final regex = RegExp(r'\b\d{6}\b');
  final match = regex.firstMatch(message);
  return match?.group(0);
}

// Contrôleur global pour OTP (facilite la mise à jour du champ Pinput)
class OtpController {
  static TextEditingController otpController = TextEditingController();

  static void updateOtp(String otp) {
    otpController.text = otp;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OtpPage(),
    );
  }
}

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  void dispose() {
    OtpController.otpController.dispose();
    super.dispose();
  }

  // Simule une notification contenant un OTP
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autocomplétion OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Pinput(
              controller: OtpController.otpController,
              length: 6,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: simulateOtpNotification,
              child: const Text('Simuler OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
