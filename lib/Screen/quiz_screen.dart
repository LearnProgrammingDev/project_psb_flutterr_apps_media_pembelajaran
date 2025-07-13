import 'package:flutter/material.dart';
import 'package:project_splashscreen/Screen/quiz_model.dart';
import 'package:project_splashscreen/Screen/result_screen.dart'; // Pastikan model sudah dibuat

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  // 🔽 Letakkan daftar soal di sini, sebelum build()
  List<QuizQuestion> questions = [
    QuizQuestion(
      question: "Apa ibu kota Indonesia?",
      options: ["Jakarta", "Bandung", "Surabaya", "Medan"],
      correctAnswerIndex: 0,
    ),
    QuizQuestion(
      question: "Berapa hasil dari 2 + 2?",
      options: ["3", "4", "5", "6"],
      correctAnswerIndex: 1,
    ),
    QuizQuestion(
      question: "Siapa penulis novel 'Laskar Pelangi'?",
      options: ["Andrea Hirata", "Pramoedya", "Tere Liye", "Dewi Lestari"],
      correctAnswerIndex: 0,
    ),
  ];

  void _checkAnswer(int selectedOption) {
    if (selectedOption == questions[currentQuestionIndex].correctAnswerIndex) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => ResultScreen(score: score, total: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kuis")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Soal ${currentQuestionIndex + 1} dari ${questions.length}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex].question,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ...questions[currentQuestionIndex].options
                .asMap()
                .map(
                  (index, option) => MapEntry(
                    index,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () => _checkAnswer(index),
                        child: Text(option),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ],
        ),
      ),
    );
  }
}
