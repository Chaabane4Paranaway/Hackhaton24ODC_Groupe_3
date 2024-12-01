import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max_it/presentation/GererMonCompte/MonCompteScreen.dart';
import 'package:max_it/presentation/GererMonCompte/try_debloque.dart';
import 'package:max_it/presentation/pages/home.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); // Retour à l'écran précédent
                  },
                ),
                const SizedBox(width: 8.0),
                const Text(
                  "Validation OTP",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Center(
              child: Text(
                "Entrez le code OTP",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Pinput(
                length: 6, // Nombre de chiffres du code OTP
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                    //border: Border.all(color: Colors.orange), // Couleur en focus
                    ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                showCursor: true, // Affiche le curseur
                onCompleted: (pin) {
                  // Vérification du code OTP
                  if (pin == "000000") {
                    showNotificationModal(context);
                  } else {
                    showErrorNotificationModal(context);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  showNotificationModal(context);
                },
                child: const Text(
                  "Renvoyer le code ?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showNotificationModal(BuildContext context) {
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
                'assets/succes.png',
                width: 100,
                height: 100,
              ),
              const Text(
                "Votre compte est débloqué. Vous pouvez maintenant profiter de tous nos services en utilisant votre code secret par défaut: 1234. Merci d’avoir utilisé le service",
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 130.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text("Fermer"),
              ),
            ],
          ),
        );
      },
    );
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
                    horizontal: 130.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text("Fermer"),
              ),
            ],
          ),
        );
      },
    );
  }
}
