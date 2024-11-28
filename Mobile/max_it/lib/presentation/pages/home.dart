import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:max_it/core/constants/sizedbox.dart';
import 'package:max_it/core/services/shared_pref_helper.dart';
import 'package:max_it/presentation/widgets/drawer.dart';
import 'package:max_it/presentation/widgets/modal_reminder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Appeler votre fonction asynchrone
      bool? shouldShowModal = await checkLastAttempt();

      if (shouldShowModal != null && shouldShowModal) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return const FractionallySizedBox(
              heightFactor: 0.4,
              child: ModalReminder(), // Votre widget personnalisé
            );
          },
        );
      }
    });
    super.initState();
  }

  checkLastAttempt() async {
    DateTime? lastAttemp = await SharedPrefManager().getLastAttempPasskey();
    Duration? frequency = const Duration(minutes: 1);
    DateTime today = DateTime.now();

    // ignore: unnecessary_null_comparison
    if (lastAttemp != null && frequency != null) {
      DateTime nextAttempDate = lastAttemp.add(frequency);
      log(lastAttemp.toString());
      log(nextAttempDate.toString());
      if (today.isAfter(nextAttempDate)) {
        log("launch reminder");
        return true;
      } else {
        log("not yet");
        log(today.difference(nextAttempDate).toString());
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

    return Scaffold(
      key: drawerKey,
      drawer: const DrawerW(),
      body: PopScope(
        canPop: false,
        child: SafeArea(
            top: false,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.paddingOf(context).top),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () => drawerKey.currentState?.openDrawer(),
                            // onTap: () => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const DrawerW())),
                            child: Image.asset('assets/picto/Male User.png')),
                        8.h,
                        const Text("00000000",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        8.h,
                        const Icon(Icons.arrow_drop_down),
                        const Spacer(),
                        Image.asset('assets/picto/Community.png'),
                        8.h
                      ],
                    ),
                    32.v,
                    Row(
                      children: [
                        const Text(
                          "Bonjour Chaabane DS",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        4.h,
                        Image.asset('assets/picto/image 296.png'),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (cotext, index) {
                            return const Padding(
                              padding: EdgeInsets.only(right: 24),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.orange,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.black87,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/solde.jpg'),
                            20.v,
                            Row(
                              children: [
                                const Text("Mes favoris",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
                                TextButton(
                                    onPressed: () {},
                                    child: const Row(
                                      children: [
                                        Text("Mes favoris",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Icon(
                                          Icons.keyboard_arrow_right_outlined,
                                          color: Colors.orange,
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            Image.asset('assets/images/favorites.jpg'),
                            const Text("J'en profite",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Image.asset('assets/images/profitez.jpg'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          elevation: 4,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: const Column(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.orange,
                        size: 30,
                      ),
                      Text("Acceuil",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/picto/orange-money.png',
                        height: 30,
                        width: 30,
                      ),
                      const FittedBox(
                          child: Text("Orange Money", style: TextStyle())),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: const Column(
                    children: [
                      Icon(
                        Icons.sim_card,
                        size: 30,
                      ),
                      Expanded(
                        child: Text("Ma Ligne", style: TextStyle()),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: const Column(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                      Expanded(
                        child: Text("Marketplace",
                            style: TextStyle(
                              fontSize: 14,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: const Column(
                    children: [
                      Icon(
                        Icons.qr_code,
                        size: 30,
                      ),
                      Expanded(
                        child: Text("Codes QR",
                            style: TextStyle(
                              fontSize: 14,
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
