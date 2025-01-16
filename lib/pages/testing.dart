import 'dart:math';

import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  final lesson;
  const Testing({required this.lesson, super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  List<Map<String, dynamic>> questions = [];
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  int score = 0;

  void handleNextQuestion() {
    if (selectedOptionIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an answer!')),
      );
      return;
    }

    // Check if the selected option is correct
    final currentQuestion = questions[currentQuestionIndex];
    if (selectedOptionIndex == currentQuestion['correctIndex']) {
      score++;
    }

    // Move to the next question or show results
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = null; // Reset the selection for the new question
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Тестілеу нәтижесі!'),
        content: Text('Сіз $score/${questions.length} сұрақтарға дұрыс жауап бердіңіз'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                currentQuestionIndex = 0;
                selectedOptionIndex = null;
                score = 0;
              });
            },
            child: Text('Restart'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> shuffleQuestions(List<dynamic> questions) {
    return questions.map((question) {
      List<String> options = List<String>.from(question['options']);
      int correctIndex = question['correctIndex'];

      // Store the correct answer before shuffling
      String correctAnswer = options[correctIndex];

      // Shuffle the options
      options.shuffle(Random());

      // Find the new index of the correct answer after shuffling
      correctIndex = options.indexOf(correctAnswer);

      return {
        "title": question['title'],
        "options": options,
        "correctIndex": correctIndex, // Store the updated index of the correct answer
      };
    }).toList();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<Map<String, dynamic>> shuffledQuestions = shuffleQuestions(widget.lesson['tests']);
    questions = shuffledQuestions;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final options = currentQuestion['options'] as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Тестілеу'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Сұрақ ${currentQuestionIndex + 1}/${questions.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              currentQuestion['title'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return RadioListTile<int>(
                    title: options[index].startsWith('assets/') ? Image.asset('${options[index]}') : Text(options[index]),
                    value: index,
                    groupValue: selectedOptionIndex,
                    onChanged: (value) {
                      setState(() {
                        selectedOptionIndex = value;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: handleNextQuestion,
              child: Text(currentQuestionIndex < questions.length - 1
                  ? 'Келесі сұрақ'
                  : 'Тапсыру'),
            ),
          ],
        ),
      ),
    );
  }
}