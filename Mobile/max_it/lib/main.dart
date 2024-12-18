import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:local_auth/local_auth.dart';
import 'package:max_it/core/routes/app_route.dart';
import 'package:max_it/core/services/biometricHelper.dart';
import 'package:max_it/core/services/shared_pref_helper.dart';
import 'package:max_it/presentation/pages/home.dart';

// void main() {
//   AwesomeNotifications().initialize(
//     null, // Icône par défaut
//     [
//       NotificationChannel(
//         channelKey: 'otp_channel',
//         channelName: 'OTP Notifications',
//         channelDescription: 'Channel for OTP messages',
//         defaultColor: Colors.blue,
//         importance: NotificationImportance.High,
//         channelShowBadge: true,
//       ),
//     ],
//   );

//   runApp(const MyApp());
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: Routes.routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  String passkey = "aucun mot secret trouvé";
  TextEditingController passkeyController = TextEditingController();

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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Debug line buttons"),
            const SizedBox(
              height: 12,
            ),
            Wrap(
              children: [
                FilledButton.tonalIcon(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const OtpPage()));
                    },
                    label: const Text("OTP")),
                const SizedBox(
                  width: 8,
                ),
                FilledButton.tonalIcon(
                    icon: const Icon(Icons.cookie),
                    onPressed: null,
                    // onPressed: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const OtpView()));
                    // },
                    label: const Text("SharedPref")),
                const SizedBox(
                  width: 8,
                ),
                Visibility(
                  visible: _supportState,
                  child: FilledButton.icon(
                      icon: const Icon(Icons.fingerprint),
                      onPressed: () async {
                        String msg = "Authentification réussie";
                        Color colour = Colors.green;
                        String? res =
                            (await BiometricHelper.authenticateForPasskey(
                                auth));
                        res == null
                            ? {
                                msg = "Erreur d'authentification",
                                colour = Colors.red
                              }
                            : {
                                (res == "N/A")
                                    ? {
                                        setState(() {
                                          passkey = "aucun mot secret trouvé";
                                        })
                                      }
                                    : {
                                        setState(() {
                                          passkey = res;
                                        })
                                      }
                              };
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: colour,
                            behavior: SnackBarBehavior.floating,
                            content: Text(msg),
                          ),
                        );
                      },
                      label: const Text("Biométrie")),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(passkey),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: passkeyController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    flex: 0,
                    child: FilledButton.tonal(
                        onPressed: () {
                          SharedPrefManager()
                              .storePasskey(passkeyController.text);
                          passkeyController.clear();
                        },
                        child: const Text("Enregistrer"))),
                Expanded(
                    flex: 0,
                    child: IconButton.filled(
                        onPressed: () => SharedPrefManager().clearPasskey(),
                        icon: const Icon(Icons.clear_rounded)))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: const Text("Home"))
          ],
        ),
      )),
    );
  }
}
