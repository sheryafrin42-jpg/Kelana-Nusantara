import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  static const Color darkBrown = Color(0xFF4A2511);
  static const Color mediumBrown = Color(0xFF6A3516);
  static const Color warmCream = Color(0xFFF9F5EC);

  final List<Map<String, dynamic>> islands = const [
    {'name': 'Pulau Sumatra', 'icon': Icons.landscape_rounded, 'color': Color(0xFFD84315)},
    {'name': 'Kepulauan Riau & Babel', 'icon': Icons.waves_rounded, 'color': Color(0xFF0288D1)},
    {'name': 'Pulau Jawa', 'icon': Icons.location_city_rounded, 'color': Color(0xFF8D6E63)},
    {'name': 'Pulau Madura', 'icon': Icons.sailing_rounded, 'color': Color(0xFFE53935)},
    {'name': 'Pulau Bali', 'icon': Icons.temple_hindu_rounded, 'color': Color(0xFFFB8C00)},
    {'name': 'Nusa Tenggara Barat', 'icon': Icons.terrain_rounded, 'color': Color(0xFFF57C00)},
    {'name': 'Nusa Tenggara Timur', 'icon': Icons.nature_people_rounded, 'color': Color(0xFFE64A19)},
    {'name': 'Pulau Kalimantan', 'icon': Icons.forest_rounded, 'color': Color(0xFF43A047)},
    {'name': 'Pulau Sulawesi', 'icon': Icons.explore_rounded, 'color': Color(0xFF1E88E5)},
    {'name': 'Kepulauan Sangir & Talaud', 'icon': Icons.anchor_rounded, 'color': Color(0xFF00ACC1)},
    {'name': 'Kepulauan Maluku', 'icon': Icons.water_rounded, 'color': Color(0xFF00897B)},
    {'name': 'Pulau Halmahera', 'icon': Icons.volcano_rounded, 'color': Color(0xFF6D4C41)},
    {'name': 'Pulau Papua', 'icon': Icons.nature_rounded, 'color': Color(0xFF2E7D32)},
    {'name': 'Pulau Biak & Yapen', 'icon': Icons.beach_access_rounded, 'color': Color(0xFF00796B)},
    {'name': 'Kepulauan Aru & Tanimbar', 'icon': Icons.map_rounded, 'color': Color(0xFF5D4037)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmCream,
      appBar: AppBar(
        title: const Text(
          'Peta 15 Wilayah Nusantara',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: darkBrown,
        elevation: 2,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A2511), Color(0xFF6A3516), Color(0xFFF9F5EC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.20, 0.60],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Informasi Peta
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.shade700, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.map_rounded, color: mediumBrown, size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pilih Wilayah Petualangan',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: darkBrown,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Pilih pulau untuk mulai menjawab kuis',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Grid Kartu 15 Pulau (Cerah & Kontras)
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: islands.length,
                    itemBuilder: (context, index) {
                      final island = islands[index];
                      final Color islandColor = island['color'] as Color;

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: islandColor.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: darkBrown.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizScreen(islandName: island['name']),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Ikon Pulau Menyala
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: islandColor.withValues(alpha: 0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      island['icon'] as IconData,
                                      color: islandColor,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Teks Nama Pulau Terang
                                  Text(
                                    island['name'] as String,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: darkBrown,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}