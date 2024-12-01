import 'dart:developer';

import 'package:local_auth/local_auth.dart';
import 'package:max_it/core/services/shared_pref_helper.dart';

class BiometricHelper {
  static Future<bool> authenticate(auth) async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: "Test",
          options: const AuthenticationOptions(
              sensitiveTransaction: true,
              stickyAuth: true,
              biometricOnly: false));
      log("Authenticated : $authenticated");
      return true;
      // return (await SharedPrefManager().getPasskey()) ?? "N/A";
    } catch (e) {
      log(e.toString());
      // return null;
      return false;
    }
  }

  static Future<String?> authenticateForPasskey(auth) async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: "Test",
          options: const AuthenticationOptions(
              sensitiveTransaction: true,
              stickyAuth: true,
              biometricOnly: false));
      log("Authenticated : $authenticated");

      return (await SharedPrefManager().getPasskey()) ?? "N/A";
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
