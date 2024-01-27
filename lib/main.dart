import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login Biometric'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            autenticate();
          },
          icon: Icon(Icons.fingerprint), // Ikon di sebelah kiri teks
          label: Text('Login'), // Teks di tombol
        ),
      ),
    );
  }

  Future<void> autenticate() async {
    // Cek apakah perangkat mendukung autentikasi biometric
    final availableBiometrics =
        await LocalAuthentication().getAvailableBiometrics();

    if (availableBiometrics.contains(BiometricType.strong)) {
      final authenticated = await LocalAuthentication().authenticate(
        localizedReason:
            'Gunakan autentikasi biometric untuk login', // Pesan yang sesuai dengan jenis biometrik yang digunakan// Gunakan BiometricType.strong untuk autentikasi biometrik kuat
      );
      if (authenticated) {
        print('autentikasi sukses');
      }
      // print(authenticated);
    }
  }
}
