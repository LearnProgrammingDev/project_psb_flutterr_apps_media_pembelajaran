import 'package:flutter/material.dart';
import 'package:project_splashscreen/Screen/result_screen.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  List<Map<String, dynamic>> questions = [
    {
      "question": "Apa ibu kota Indonesia?",
      "options": ["Jakarta", "Bandung", "Surabaya", "Medan"],
      "answer": 0,
    },
    {
      "question": "Berapa hasil dari 2 + 2?",
      "options": ["3", "4", "5", "6"],
      "answer": 1,
    },
    {
      "question": "Siapa penulis novel 'Laskar Pelangi'?",
      "options": ["Andrea Hirata", "Pramoedya", "Tere Liye", "Dewi Lestari"],
      "answer": 0,
    },
  ];

  void _checkAnswer(int selectedOption) {
    if (selectedOption == questions[currentQuestionIndex]["answer"]) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.push(
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
      appBar: AppBar(title: const Text("Latihan Soal")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Soal ${currentQuestionIndex + 1} dari ${questions.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              questions[currentQuestionIndex]["question"].toString(),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ...List.generate(
              questions[currentQuestionIndex]["options"].length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => _checkAnswer(index),
                  child: Text(
                    questions[currentQuestionIndex]["options"][index],
                  ),
                ),
              ),
            ).toList(),
          ],
        ),
      ),
    );
  }
}
