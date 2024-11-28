import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:max_it/core/constants/sizedbox.dart';
import 'package:max_it/core/services/shared_pref_helper.dart';
import 'package:max_it/presentation/GererMonCompte/MonCompteScreen.dart';
import 'package:max_it/presentation/otp/otp.dart';

class ModalReminder extends StatefulWidget {
  const ModalReminder({super.key});

  @override
  State<ModalReminder> createState() => _ModalReminderState();
}

class _ModalReminderState extends State<ModalReminder> {
  TextEditingController passkeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding:
              const EdgeInsets.all(24).subtract(const EdgeInsets.only(top: 12)),
          child: Column(
            children: [
              16.v,
              const Text(
                "Rappel de mot de secret",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              8.v,
              const Text(
                "Valider votre mot secret pour continuer\nVous pouvez le modifier à tout moment dans les paramètres.",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              16.v,
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: passkeyController,
                keyboardType: TextInputType.text,
              ),
              16.v,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     foregroundColor: Colors.black,
                  //     elevation: 0,
                  //     side: const BorderSide(color: Colors.black),
                  //     padding: const EdgeInsets.symmetric(
                  //       vertical: 12.0,
                  //       horizontal: 50.0,
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //   ),
                  //   child: const Text("Quitter"),
                  // ),

                  ElevatedButton(
                    onPressed: () {
                      if (passkeyController.text.trim().toLowerCase() ==
                          "maman") {
                        Navigator.pop(context);
                        SharedPrefManager()
                            .storeLastAttempPasskey(DateTime.now());
                      } else {
                        Navigator.pop(context);
                        Get.to(() => const MonCompteScreen());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 50.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text("Valider"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
