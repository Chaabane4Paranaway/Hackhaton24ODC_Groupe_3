import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:max_it/core/services/biometricHelper.dart';
import 'package:max_it/presentation/pages/otp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
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
            Wrap(
              children: [
                FilledButton.tonalIcon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OtpView()));
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
                FilledButton.icon(
                    icon: const Icon(Icons.fingerprint),
                    onPressed: () async {
                      String msg = "Authentification réussie";
                      Color colour = Colors.green;
                      await BiometricHelper.authenticate(auth)
                          ? {}
                          : {
                              msg = "Erreur d'authentification",
                              colour = Colors.red
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
              ],
            )
          ],
        ),
      )),
    );
  }
}
