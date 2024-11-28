import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/route_manager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:max_it/core/constants/sizedbox.dart';
import 'package:max_it/core/services/biometricHelper.dart';
import 'package:max_it/presentation/GererMonCompte/MonCompteScreen.dart';
import 'package:max_it/presentation/pages/debloqueAccount.dart';
import 'package:max_it/presentation/pages/survey.dart';
import 'package:max_it/presentation/widgets/modal_pin.dart';

class DrawerW extends StatefulWidget {
  const DrawerW({
    super.key,
  });

  @override
  State<DrawerW> createState() => _DrawerWState();
}

class _DrawerWState extends State<DrawerW> {
  bool isBiometricEnabled = false;
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: Container(
          width: MediaQuery.sizeOf(context).width - 8,
          color: Colors.white,
          child: Column(
            children: [
              MediaQuery.paddingOf(context).top.v,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  16.h,
                  Expanded(
                      flex: 0,
                      child: Image.asset('assets/picto/Client Management.png')),
                  16.h,
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Chaabanedavysteve Nacro",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        Text("Mon compte",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 0,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.close,
                          size: 50,
                        ),
                      )),
                  16.h
                ],
              ),
              32.v,
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    const Divider(
                      color: Colors.orange,
                      thickness: 4,
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child:
                                  Image.asset('assets/picto/Fingerprint.png'),
                            )),
                        title: const Text("Biométrie"),
                        trailing: Switch(
                            activeTrackColor: Colors.green,
                            value: isBiometricEnabled,
                            onChanged: (value) {
                              if (isBiometricEnabled == false) {
                                BiometricHelper.authenticate(auth)
                                    .then((value) {
                                  if (value) {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        context: context,
                                        builder: (context) {
                                          return const ModalPinInput();
                                        });
                                  }
                                });
                              }
                              setState(() {
                                isBiometricEnabled = value;
                              });
                            }),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => null));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          onTap: () => Get.to(() => const MonCompteScreen()),
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child:
                                    Image.asset('assets/picto/Admin male.png'),
                              )),
                          title: const Text("Gérer mon compte Orange Money"),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Image.asset('assets/images/drawer.jpg'),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
