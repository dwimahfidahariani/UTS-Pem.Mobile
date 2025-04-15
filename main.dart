import 'package:flutter/material.dart';
import 'hasil_kuis.dart'; // Kalau hasil_kuis.dart digabung, bagian ini bisa dihapus

void main() {
  runApp(const Quizify());
}

class Quizify extends StatelessWidget {
  const Quizify({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF4989c6),
      ),
    );
  }
}

// ===========================
// HALAMAN LOGIN
// ===========================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_usernameController.text == "user" && _passwordController.text == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: _usernameController.text),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username atau password salah")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFA1BAD2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFA1BAD2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: const Text("Masuk")),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================
// HALAMAN HOME
// ===========================
class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Selamat datang, $username!", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(username: username),
                  ),
                );
              },
              child: const Text("Mulai Kuis"),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================
// HALAMAN QUIZ
// ===========================
class QuizScreen extends StatefulWidget {
  final String username;
  const QuizScreen({super.key, required this.username});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  int _nomor = 0;
  int _benar = 0;
  int _salah = 0;
  int _score = 0;
  String? _selectedOption;

  final List<String> _soal = [
    "Apa itu pemrograman mobile?",
    "Sistem operasi utama yang digunakan dalam pengembangan aplikasi mobile adalah...",
    "Bahasa pemrograman utama untuk pengembangan aplikasi Android adalah...",
    "Framework yang digunakan untuk mengembangkan aplikasi iOS adalah...",
    "Apa itu APK dalam pengembangan aplikasi Android?",
    "Dalam pengembangan Android, fungsi dari 'Gradle' adalah...",
    "Perintah XML untuk mendefinisikan tata letak UI di Android adalah...",
    "Bahasa pemrograman utama untuk pengembangan aplikasi iOS adalah...",
    "Apa kepanjangan dari API dalam pemrograman mobile?",
    "Framework yang digunakan untuk pengembangan aplikasi mobile lintas platform adalah..."
  ];

  final List<List<String>> _option = [
    ["Pemrograman untuk perangkat komputer desktop", "Pemrograman yang berfokus pada aplikasi mobile", "Pemrograman yang hanya digunakan untuk game", "Pemrograman berbasis hardware"],
    ["Windows dan Linux", "Android dan iOS", "macOS dan Ubuntu", "Unix dan Solaris"],
    ["Swift", "Java dan Kotlin", "C#", "Python"],
    ["Android Studio", "Xcode", "Eclipse", "Visual Studio Code"],
    ["Alat debugging untuk Android", "Format file aplikasi Android yang dapat diinstal", "Bahasa pemrograman khusus Android", "Emulator untuk menjalankan aplikasi"],
    ["Mengatur tampilan aplikasi", "Mengelola dependensi dan membangun proyek", "Menjalankan emulator Android", "Menghubungkan aplikasi dengan server"],
    ["<android:layout>", "<layout>", "<RelativeLayout> atau <LinearLayout>", "<Design>"],
    ["Java", "Kotlin", "Swift", "Ruby"],
    ["Application Programming Interface", "Android Programming Interface", "Automated Program Integration", "Advanced Processing Input"],
    ["Flutter dan React Native", "Kotlin dan Swift", "Android Studio dan Xcode", "Java dan Objective-C"]
  ];

  final List<String> _jawaban = [
    "Pemrograman yang berfokus pada aplikasi mobile",
    "Android dan iOS",
    "Java dan Kotlin",
    "Xcode",
    "Format file aplikasi Android yang dapat diinstal",
    "Mengelola dependensi dan membangun proyek",
    "<RelativeLayout> atau <LinearLayout>",
    "Swift",
    "Application Programming Interface",
    "Flutter dan React Native"
  ];

  void _cekJawaban() {
    if (_selectedOption == _jawaban[_nomor]) {
      _benar++;
    } else {
      _salah++;
    }
    _lanjutSoal();
  }

  void _lanjutSoal() {
    setState(() {
      if (_nomor < _soal.length - 1) {
        _nomor++;
        _selectedOption = null;
      } else {
        _selesaiKuis();
      }
    });
  }

  void _selesaiKuis() {
    _score = _benar * 10;
