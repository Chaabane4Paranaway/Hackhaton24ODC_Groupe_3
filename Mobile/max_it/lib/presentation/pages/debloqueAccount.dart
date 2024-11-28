// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../otp/otp.dart';

// class UnlockAccountPage extends StatefulWidget {
//   const UnlockAccountPage({Key? key}) : super(key: key);

//   @override
//   _UnlockAccountPageState createState() => _UnlockAccountPageState();
// }

// class _UnlockAccountPageState extends State<UnlockAccountPage> {
//   final TextEditingController _dateController = TextEditingController();
//   String? selectedName;
//   String? selectedFirstName;
//   String? selectedFirstDate;
//   String? selectedFirstCNIB;

//   final List<String> names = ['Kouraogo', 'Ouedraogo', 'Bazie'];
//   final List<String> firstNames = [
//     'Marc',
//     'Jean-François',
//     'Delwende Patricia',
//     'Pengdwende Nina'
//   ];
//   final List<String> firstDate = [
//     '12/10/2001',
//     '12/10/2005',
//     '12/10/1991',
//     '12/10/1996'
//   ];
//   final List<String> firstCNIB = [
//     'bZq12102001',
//     'QR12102005',
//     'CD12101991',
//     'B1101996'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
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
//                   "Debloquez votre compte",
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Sélectionnez ou entrez votre nom',
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//             const SizedBox(height: 8),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 focusedBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//               ),
//               value: selectedName,
//               items: names
//                   .map((name) => DropdownMenuItem<String>(
//                         value: name,
//                         child: Text(name),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedName = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Sélectionnez votre prénom(s)',
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//             const SizedBox(height: 8),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 focusedBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//               ),
//               value: selectedFirstName,
//               items: firstNames
//                   .map((firstName) => DropdownMenuItem<String>(
//                         value: firstName,
//                         child: Text(firstName),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFirstName = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Sélectionnez votre date de naissance',
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _dateController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 hintText: "JJ-MM-AAAA",
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.calendar_today),
//                   onPressed: () async {
//                     final DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(1900),
//                       lastDate: DateTime.now(),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         _dateController.text =
//                             "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
//                       });
//                     }
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Entrez votre numéro CNIB',
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//             const SizedBox(height: 8),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 focusedBorder: const UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//               ),
//               value: selectedFirstCNIB,
//               items: firstCNIB
//                   .map((cnib) => DropdownMenuItem<String>(
//                         value: cnib,
//                         child: Text(cnib),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedFirstCNIB = value;
//                 });
//               },
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     if (selectedName == "Kouraogo" &&
//                         selectedFirstName == "Marc" &&
//                         _dateController.text == "12/10/2001" &&
//                         selectedFirstCNIB == "bZq12102001") {
//                       Get.to(() => const OtpScreen());
//                     } else {
//                       showErrorNotificationModal(context);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     foregroundColor: Colors.white,
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
//                 ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 12.0,
//                   horizontal: 100.0,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               child: const Text("Quitter"),
//             ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void showErrorNotificationModal(BuildContext context) {
//     showModalBottomSheet(
//       backgroundColor: Colors.white,
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(
//                 'assets/erreur.png',
//                 width: 100,
//                 height: 100,
//               ),
//               const Text(
//                 "Votre demande de déblocage a échoué, suite à des informations incorrectes. Veuillez réessayer.",
//                 textAlign: TextAlign.center,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 12.0,
//                     horizontal: 130.0,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//                 child: const Text("Fermer"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnlockAccountPage extends StatefulWidget {
  const UnlockAccountPage({super.key});

  @override
  _UnlockAccountPageState createState() => _UnlockAccountPageState();
}

class _UnlockAccountPageState extends State<UnlockAccountPage> {
  final TextEditingController _dateController = TextEditingController();
  // final UserController userController = Get.put(UserController());

  String? selectedName;
  String? selectedFirstName;
  String? selectedDate;
  String? selectedCNIB;

  @override
  void initState() {
    super.initState();
    // userController.fetchClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
        child: Column(
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
                  "Débloquez votre compte",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              // Ajoutez Expanded ici
              child: Obx(() {
                // if (userController.isLoading.value) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                // if (userController.clients.isEmpty) {
                //   return const Center(child: Text('Aucun client trouvé.'));
                // }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sélectionnez ou entrez votre nom',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        value: selectedName,
                        items: const [],
                        // userController.clients
                        //     .map((client) => DropdownMenuItem<String>(
                        //           value: client['lastName'],
                        //           child: Text(client['lastName']),
                        //         ))
                        //     .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedName = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Sélectionnez votre prénom(s)',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        value: selectedFirstName,
                        items: const [],
                        //  userController.clients
                        //     .map((client) => DropdownMenuItem<String>(
                        //           value: client['firstName'],
                        //           child: Text(client['firstName']),
                        //         ))
                        //     .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedFirstName = value;
                          });
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
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
                "Votre demande de déblocage a échoué, suite à des informations incorrectes. Veuillez réessayer.",
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
