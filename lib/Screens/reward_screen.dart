import 'package:flutter/material.dart';

// Variabel global untuk menyimpan koin
int globalCoins = 0;

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  final List<Map<String, dynamic>> badges = [
    {
      'title': 'Penjelajah Jawa',
      'icon': Icons.account_balance_rounded,
      'description': 'Menyelesaikan Kuis Kebudayaan Jawa',
      'requiredCoins': 50,
    },
    {
      'title': 'Pakar Sumatra',
      'icon': Icons.landscape_rounded,
      'description': 'Menyelesaikan Kuis Kebudayaan Sumatra',
      'requiredCoins': 100,
    },
    {
      'title': 'Pelaut Sulawesi',
      'icon': Icons.directions_boat_rounded,
      'description': 'Menyelesaikan Kuis Kebudayaan Sulawesi',
      'requiredCoins': 150,
    },
    {
      'title': 'Penjaga Borneo',
      'icon': Icons.park_rounded,
      'description': 'Menyelesaikan Kuis Kebudayaan Kalimantan',
      'requiredCoins': 200,
    },
    {
      'title': 'Seniman Bali & NT',
      'icon': Icons.music_note_rounded,
      'description': 'Menyelesaikan Kuis Bali & Nusa Tenggara',
      'requiredCoins': 250,
    },
    {
      'title': 'Ksatria Cenderawasih',
      'icon': Icons.wb_sunny_rounded,
      'description': 'Menyelesaikan Kuis Papua & Maluku',
      'requiredCoins': 300,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koleksi & Reward', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF8B4513),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B4513), Color(0xFFA0522D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 50),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Koin Nusantara',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$globalCoins Koin',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Lencana Kelana Nusantara',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF8B4513)),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: badges.length,
              itemBuilder: (context, index) {
                final badge = badges[index];
                final bool isUnlocked = globalCoins >= badge['requiredCoins'];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isUnlocked ? Colors.amber[100] : Colors.grey[200],
                      child: Icon(
                        badge['icon'],
                        color: isUnlocked ? const Color(0xFF8B4513) : Colors.grey,
                      ),
                    ),
                    title: Text(
                      badge['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isUnlocked ? Colors.black87 : Colors.grey,
                      ),
                    ),
                    subtitle: Text(
                      badge['description'],
                      style: TextStyle(color: isUnlocked ? Colors.black54 : Colors.grey[400]),
                    ),
                    trailing: isUnlocked
                        ? const Icon(Icons.verified_rounded, color: Colors.green)
                        : Text(
                            '${badge['requiredCoins']} Koin',
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}