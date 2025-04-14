import 'package:flutter/material.dart';
import 'main.dart';

class HasilKuis extends StatelessWidget {
  final int score;
  final int benar;
  final int salah;

  const HasilKuis({super.key, required this.score, required this.benar, required this.salah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hasil Kuis")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Skor Anda: $score", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Benar: $benar", style: const TextStyle(fontSize: 18, color: Colors.white)),
              Text("Salah: $salah", style: const TextStyle(fontSize: 18, color: Colors.red)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => const QuizScreen())
                    );
                },
                child: const Text("Coba Lagi"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Quizify()));
                },
                child: const Text("Kembali ke Halaman Utama"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}