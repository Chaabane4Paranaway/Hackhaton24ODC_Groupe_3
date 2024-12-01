import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_it/presentation/otp/otp.dart';
import 'package:max_it/presentation/pages/debloqueAccount.dart';

import 'package:pinput/pinput.dart';

class TryDebloque extends StatelessWidget {
  const TryDebloque({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController secretController = TextEditingController();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8.0),
                const Text(
                  "Debloquer votre compte",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            const Text(
              "l’indice qui vous permettra de vous rappeller de votre mot secet ex: La personne que j’aime le plus a Ouagadougou",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5.0),
            TextField(
              controller: secretController,
              decoration: const InputDecoration(
                labelText: "Entrer votre mot secret",
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    Get.to(() => const UnlockAccountPage());
                  },
                  child: const Text(
                    'mot secret oublier ?',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  )),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 50.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text("Quitter"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (secretController.text.trim().toLowerCase() == "maman") {
                      Get.to(() => const OtpScreen());
                    } else {
                      showErrorNotificationModal(context);
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
            )
          ],
        ),
      ),
    ));
  }

  void showErrorNotificationModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/erreur.png',
                width: 100,
                height: 100,
              ),
              const Text(
                "Votre demande de déblocage a échoué, suite à des informations incorrectes. Veuillez saisir à nouveau vos informations ou appeler le service client au 0707 ou vous rendre dans une agence.",
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const TryDebloque());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 50.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text("Réessayer"),
              ),
            ],
          ),
        );
      },
    );
  }
}
