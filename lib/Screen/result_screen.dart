import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({Key? key, required this.score, required this.total})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hasil Latihan")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kamu menjawab $score dari $total soal dengan benar.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              label: const Text("Kembali"),
            ),
          ],
        ),
      ),
    );
  }
}
