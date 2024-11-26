import 'dart:developer';

import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  static Future<bool> authenticate(auth) async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: "Test",
          options: const AuthenticationOptions(
              sensitiveTransaction: true,
              stickyAuth: true,
              biometricOnly: true));
      log("Authenticated : $authenticated");
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
