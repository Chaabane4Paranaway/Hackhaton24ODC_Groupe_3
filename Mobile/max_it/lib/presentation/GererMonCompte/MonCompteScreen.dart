import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:max_it/core/services/shared_pref_helper.dart';
import 'package:max_it/presentation/GererMonCompte/createMotSecret.dart';
import 'package:max_it/presentation/GererMonCompte/try.dart';
import 'package:max_it/presentation/otp/otp.dart';
import 'package:max_it/presentation/pages/debloqueAccount.dart';

import 'try_debloque.dart';
import 'updateMotSecret.dart';

class MonCompteScreen extends StatefulWidget {
  const MonCompteScreen({super.key});

  @override
  State<MonCompteScreen> createState() => _MonCompteScreenState();
}

class _MonCompteScreenState extends State<MonCompteScreen> {
  bool? isReminderEnabled, isLocalSaveEnabled;

  Future<bool> _authenticate(BuildContext context) async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Veuillez authentifier pour débloquer votre compte',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      if (didAuthenticate) {
        // Naviguer vers la page "Débloquer mon compte"
        // Get.to(() => const OtpScreen());
        return true;
      } else {
        runZonedGuarded(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Authentification échouée.")),
          );
        }, (e, s) => log(e.toString()));
        return false;
      }
    } catch (e) {
      runZonedGuarded(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Authentification échouée.")),
        );
      }, (e, s) => log(e.toString()));
      return false;
    }
  }

  @override
  void initState() {
    initLocalSaveBool();
    initReminderBool();
    super.initState();
  }

  initReminderBool() async {
    DateTime? lastAttempt = await SharedPrefManager().getLastAttempPasskey();
    bool res = (lastAttempt == null) ? false : true;
    // print(await SharedPrefManager().getLastAttempPasskey());
    setState(() {
      isReminderEnabled = res;
    });
  }

  initLocalSaveBool() async {
    String? passkey = await SharedPrefManager().getPasskey();
    bool res = passkey == null ? false : true;
    setState(() {
      isLocalSaveEnabled = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/client.png',
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Boukary Abdoul Kouraogo",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Mon compte",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "Mon compte Orange Money",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          const Divider(color: Colors.orange, thickness: 2),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildOptionItem(
                  svgPath: 'assets/Password.png',
                  text: "Mot secret",
                  onTap: () {
                    _showMotSecretDialog(context);
                  },
                ),
                GestureDetector(
                  onDoubleTap: () {
                    // Redirection vers UnlockAccountPage pour un double clic
                    //Get.to(()=>UnlockAccountPage());
                    Get.to(() => const TryUnlock());
                  },
                  child: _buildOptionItem(
                    svgPath: 'assets/number.png',
                    text: "Débloquer mon compte",
                    onTap: () async {
                      if (await _authenticate(context)) {
                        Get.to(() => const OtpScreen());
                      } else {
                        Get.to(() => const UnlockAccountPage());
                      }
                    },
                  ),
                ),
                _buildOptionItem(
                  svgPath: 'assets/Password.png',
                  text: "Rappeler mon mot secret",
                  isActive: isReminderEnabled,
                  onTap: () async {
                    if (isReminderEnabled != null) {
                      DateTime attempDate = DateTime.now();
                      (await _authenticate(context))
                          ? {
                              if (isReminderEnabled!)
                                {
                                  await SharedPrefManager()
                                      .clearLastAttemptPasskey(),
                                  log("Reminder disabled"),
                                }
                              else
                                {
                                  log("Reminder enabled at $attempDate"),
                                  await SharedPrefManager()
                                      .storeLastAttempPasskey(attempDate),
                                },
                              setState(() {
                                isReminderEnabled = !isReminderEnabled!;
                              })
                            }
                          : {};
                    }
                  },
                ),
                _buildOptionItem(
                  svgPath: 'assets/Password.png',
                  text: "Sauvegarde locale",
                  isActive: isLocalSaveEnabled,
                  onTap: () async {
                    if (isLocalSaveEnabled != null) {
                      (await _authenticate(context))
                          ? {
                              if (isLocalSaveEnabled!)
                                {
                                  await SharedPrefManager().clearPasskey(),
                                  log("Save removed"),
                                }
                              else
                                {
                                  log("PAsskey saved"),
                                  await SharedPrefManager()
                                      .storePasskey("maman"),
                                },
                              setState(() {
                                isLocalSaveEnabled = !isLocalSaveEnabled!;
                              })
                            }
                          : {};
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem({
    required String svgPath,
    required String text,
    required VoidCallback onTap,
    bool? isActive,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              svgPath,
              color: Colors.orange,
              width: 24,
              height: 24,
            ),
          ),
          title: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          onTap: onTap,
          trailing: isActive == null
              ? null
              : Text(
                  isActive ? "Activé" : "Désactivé",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive ? Colors.orange : Colors.grey,
                  ),
                ),
        ),
      ),
    );
  }

  void _showMotSecretDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const CreerMotSecretScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade100,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text("Créer un mot secret"),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const ModifierMotSecretScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade100,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text("Modifier le mot secret"),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
