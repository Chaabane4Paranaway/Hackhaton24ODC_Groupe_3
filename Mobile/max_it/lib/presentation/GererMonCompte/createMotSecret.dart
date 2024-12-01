// import 'package:flutter/material.dart';

// class CreerMotSecretScreen extends StatefulWidget {
//   const CreerMotSecretScreen({Key? key}) : super(key: key);

//   @override
//   State<CreerMotSecretScreen> createState() => _CreerMotSecretScreenState();
// }

// class _CreerMotSecretScreenState extends State<CreerMotSecretScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.black),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 const SizedBox(width: 8.0),
//                 const Text(
//                   "Créer un mot secret",
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 32.0),
//             const TextField(
//               decoration: InputDecoration(
//                 labelText: "Entrer un indice",
//                 labelStyle: TextStyle(color: Colors.black),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24.0),
//             const TextField(
//               decoration: InputDecoration(
//                 labelText: "Entrer votre mot secret",
//                 labelStyle: TextStyle(color: Colors.black),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//               ),
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.black,
//                     elevation: 0,
//                     side: const BorderSide(color: Colors.black),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 12.0,
//                       horizontal: 50.0,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text("Quitter"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _showBottomSheet(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     foregroundColor: Colors.white,
//                     elevation: 0,
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 12.0,
//                       horizontal: 50.0,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text("Valider"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       backgroundColor: Colors.white,
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Taper votre code secret Orange Money pour enregistrer l'authentification biométrique",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16.0),
//               ),
//               const SizedBox(height: 20.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   4,
//                   (index) => Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Container(
//                       width: 25.0,
//                       height: 25.0,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.orange, width: 2.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20.0),
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 8,
//                   crossAxisSpacing: 8,
//                 ),
//                 itemCount: 12,
//                 //padding: EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 50),
//                 itemBuilder: (context, index) {
//                   if (index == 9) {
//                     return IconButton(
//                       icon: const Icon(Icons.backspace, color: Colors.orange),
//                       onPressed: () {
//                         // Logique pour supprimer un chiffre
//                       },
//                     );
//                   } else if (index == 11) {
//                     return ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         // Ajoutez votre logique de validation ici
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange,
//                         foregroundColor: Colors.white,
//                         //shape: const CircleBorder(),
//                         //padding: const EdgeInsets.all(16.0),
//                       ),
//                       child: const Text("OK"),
//                     );
//                   } else {
//                     int number = index < 9 ? index + 1 : 0;
//                     return ElevatedButton(
//                       onPressed: () {
//                         // Logique pour ajouter un chiffre
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.orange,
//                         //shape: const CircleBorder(),
//                         side: const BorderSide(color: Colors.orange, width: 2),
//                         //padding: const EdgeInsets.all(10.0),
//                       ),
//                       child: Text(
//                         "$number",
//                         style: const TextStyle(fontSize: 12.0, color: Colors.black),
//                       ),
//                     );
//                   }
//                 },
//               ),
//               const SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 12.0,
//                     horizontal: 120.0,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//                 child: const Text("Quitter"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CreerMotSecretScreen extends StatefulWidget {
  const CreerMotSecretScreen({Key? key}) : super(key: key);

  @override
  State<CreerMotSecretScreen> createState() => _CreerMotSecretScreenState();
}

class _CreerMotSecretScreenState extends State<CreerMotSecretScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
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
                  "Créer un mot secret",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            const TextField(
              decoration: InputDecoration(
                labelText: "Entrer un indice",
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const TextField(
              decoration: InputDecoration(
                labelText: "Entrer votre mot secret",
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
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
                    _showBottomSheet(context);
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
    );
  }

void _showBottomSheet(BuildContext context) {
  final TextEditingController _pinController = TextEditingController();

  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Taper votre code secret Orange Money pour enregistrer votre mot secret",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Pinput(
              controller: _pinController,
              length: 4,
              obscureText: true, // Masquer la saisie avec des points noirs
              obscuringCharacter: '●',
              showCursor: true,
              defaultPinTheme: PinTheme(
                width: 50, // Réduction de la largeur des cercles
                height: 50, // Réduction de la hauteur des cercles
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 6, // Espacement réduit
                crossAxisSpacing: 6,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index == 9) {
                  return IconButton(
                    icon: const Icon(Icons.backspace, color: Colors.orange),
                    onPressed: () {
                      if (_pinController.text.isNotEmpty) {
                        _pinController.text = _pinController.text
                            .substring(0, _pinController.text.length - 1);
                      }
                    },
                  );
                } else if (index == 11) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Ajoutez votre logique de validation ici
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(12.0), // Taille réduite
                    ),
                    child: const Text("OK"),
                  );
                } else {
                  int number = index < 9 ? index + 1 : 0;
                  return ElevatedButton(
                    onPressed: () {
                      if (_pinController.text.length < 4) {
                        _pinController.text += number.toString();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.orange,
                      side: const BorderSide(color: Colors.orange, width: 2),
                      padding: const EdgeInsets.all(12.0), // Taille réduite
                      shape: const CircleBorder(),
                    ),
                    child: Text(
                      "$number",
                      style: const TextStyle(fontSize: 16.0), // Taille de texte ajustée
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 100.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text("Quitter"),
            ),
          ],
        ),
      );
    },
  );
}
}
