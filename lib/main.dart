import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Game',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

// ================= HOME PAGE =================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.quiz, size: 100, color: Colors.white),

              const SizedBox(height: 20),

              const Text(
                'QUIZ GAME',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Test your knowledge!',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),

              const SizedBox(height: 50),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 55,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'START QUIZ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= QUESTIONS =================

class Question {
  final String question;
  final List<String> answers;
  final int correctAnswer;

  Question({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });
}

final List<Question> questions = [
  Question(
    question: 'What is the capital of France?',
    answers: ['London', 'Paris', 'Berlin', 'Madrid'],
    correctAnswer: 1,
  ),

  Question(
    question: 'How many planets are in the Solar System?',
    answers: ['7', '8', '9', '10'],
    correctAnswer: 1,
  ),

  Question(
    question: 'Which language is used to build Flutter apps?',
    answers: ['Python', 'Java', 'Dart', 'C++'],
    correctAnswer: 2,
  ),

  Question(
    question: 'What is 5 + 7?',
    answers: ['10', '11', '12', '13'],
    correctAnswer: 2,
  ),

  Question(
    question: 'Which animal is known as the King of the Jungle?',
    answers: ['Tiger', 'Lion', 'Elephant', 'Wolf'],
    correctAnswer: 1,
  ),

  Question(
    question: 'What color do you get by mixing blue and yellow?',
    answers: ['Green', 'Purple', 'Orange', 'Pink'],
    correctAnswer: 0,
  ),

  Question(
    question: 'Which planet is known as the Red Planet?',
    answers: ['Venus', 'Mars', 'Jupiter', 'Mercury'],
    correctAnswer: 1,
  ),

  Question(
    question: 'How many days are there in a week?',
    answers: ['5', '6', '7', '8'],
    correctAnswer: 2,
  ),

  Question(
    question: 'Which is the largest ocean?',
    answers: [
      'Atlantic Ocean',
      'Indian Ocean',
      'Arctic Ocean',
      'Pacific Ocean',
    ],
    correctAnswer: 3,
  ),

  Question(
    question: 'What does HTML stand for?',
    answers: [
      'Hyper Text Markup Language',
      'High Tech Modern Language',
      'Home Tool Markup Language',
      'Hyperlink Text Management Language',
    ],
    correctAnswer: 0,
  ),
];

// ================= QUIZ PAGE =================

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;
  int? selectedAnswer;

  void selectAnswer(int index) {
    if (selectedAnswer != null) return;

    setState(() {
      selectedAnswer = index;

      if (index == questions[currentQuestion].correctAnswer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (selectedAnswer == null) return;

    if (currentQuestion == questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultPage(score: score)),
      );
    } else {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // QUESTION NUMBER
            Text(
              'Question ${currentQuestion + 1} / ${questions.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 15),

            // PROGRESS BAR
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
            ),

            const SizedBox(height: 40),

            // QUESTION
            Text(
              question.question,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // ANSWERS
            ...List.generate(question.answers.length, (index) {
              bool isSelected = selectedAnswer == index;
              bool isCorrect = index == question.correctAnswer;

              Color? backgroundColor;

              if (selectedAnswer != null) {
                if (isCorrect) {
                  backgroundColor = Colors.green;
                } else if (isSelected) {
                  backgroundColor = Colors.red;
                }
              }

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 15),

                child: ElevatedButton(
                  onPressed: () {
                    selectAnswer(index);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    foregroundColor: backgroundColor != null
                        ? Colors.white
                        : Colors.black87,

                    padding: const EdgeInsets.all(18),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,

                        child: Text(String.fromCharCode(65 + index)),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Text(
                          question.answers[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Spacer(),

            // NEXT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedAnswer == null ? null : nextQuestion,

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                child: Text(
                  currentQuestion == questions.length - 1 ? 'FINISH' : 'NEXT',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= RESULT PAGE =================

class ResultPage extends StatelessWidget {
  final int score;

  const ResultPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    String message;

    if (score >= 8) {
      message = 'Excellent! 🎉';
    } else if (score >= 5) {
      message = 'Good job! 👍';
    } else {
      message = 'Try again! 💪';
    }

    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Icon(Icons.emoji_events, size: 100, color: Colors.white),

              const SizedBox(height: 20),

              const Text(
                'QUIZ COMPLETE!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                '$score / ${questions.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 50),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                },

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 18,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                child: const Text(
                  'PLAY AGAIN',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text(
                  'BACK TO HOME',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
