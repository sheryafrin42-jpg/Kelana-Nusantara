import 'package:flutter/material.dart';
import 'reward_screen.dart';

class QuizReviewScreen extends StatelessWidget {
  final List<Map<String, dynamic>> userAnswers;
  final int totalScore;

  const QuizReviewScreen({
    super.key,
    required this.userAnswers,
    required this.totalScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat & Review Jawaban', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF8B4513),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFFFF8E7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Poin Diraih:', style: TextStyle(color: Colors.black54)),
                    Text(
                      '$totalScore Poin',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF8B4513)),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B4513),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.card_giftcard_rounded, color: Colors.amber),
                  label: const Text('Lihat Reward'),
                  onPressed: () {
                    globalCoins += totalScore;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RewardScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: userAnswers.length,
              itemBuilder: (context, index) {
                final item = userAnswers[index];
                final bool isCorrect = item['isCorrect'];
                final List options = item['options'];
                final int selectedIndex = item['selectedAnswer'];
                final int correctAnswerIndex = item['correctAnswer'];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isCorrect ? Colors.green : Colors.red,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Soal ${index + 1} (${isCorrect ? "+20 Poin" : "0 Poin"})',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isCorrect ? Colors.green[800] : Colors.red[800],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['question'],
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(options.length, (optIdx) {
                            bool isUserPick = optIdx == selectedIndex;
                            bool isTargetCorrect = optIdx == correctAnswerIndex;

                            Color tileColor = Colors.transparent;
                            Color textColor = Colors.black87;
                            IconData? optIcon;

                            if (isTargetCorrect) {
                              tileColor = Colors.green.shade50;
                              textColor = Colors.green.shade900;
                              optIcon = Icons.check;
                            } else if (isUserPick && !isCorrect) {
                              tileColor = Colors.red.shade50;
                              textColor = Colors.red.shade900;
                              optIcon = Icons.close;
                            }

                            return Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: tileColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '${String.fromCharCode(65 + optIdx)}. ${options[optIdx]}',
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: (isUserPick || isTargetCorrect) ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (optIcon != null) Icon(optIcon, size: 18, color: textColor),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}