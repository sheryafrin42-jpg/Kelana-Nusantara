import 'package:flutter/material.dart';
import '../services/coin_service.dart';
import 'map_screen.dart';
import 'reward_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, this.userName = 'Penjelajah'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _userCoins = 0; // Memegang data koin lokal real-time

  static const Color darkBrown = Color(0xFF4A2511);
  static const Color mediumBrown = Color(0xFF6A3516);
  static const Color warmCream = Color(0xFFF9F5EC);

  @override
  void initState() {
    super.initState();
    _loadCoins(); // Memuat koin tersimpan saat Home Screen dinyalakan
  }

  // Fungsi untuk mengambil koin dari memori HP
  Future<void> _loadCoins() async {
    int savedCoins = await CoinService.getCoins();
    setState(() {
      _userCoins = savedCoins;
    });
  }

  void _navigateTo(Widget targetScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    ).then((_) {
      // Memperbarui koin kembali saat pemain selesai dari Quiz/Map
      _loadCoins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmCream,
      appBar: AppBar(
        title: const Text(
          'Kelana Nusantara',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        backgroundColor: darkBrown,
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.card_giftcard_rounded, color: Colors.amber),
            tooltip: 'Koleksi Reward',
            onPressed: () => _navigateTo(const RewardScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profil & Statistik Koin
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: darkBrown,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.amber, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            'assets/images/logo_app.jpg',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo, ${widget.userName}! 👋',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Siap menjelajahi warisan Nusantara?',
                              style: TextStyle(fontSize: 13, color: Color(0xFFE0D0C0)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.amber.withValues(alpha: 0.6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'Koin Nusantara',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          '$_userCoins Koin',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Banner Petualangan Utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [mediumBrown, darkBrown],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: darkBrown.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.explore_rounded, color: Colors.amber, size: 28),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Petualangan Utama',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Uji pengetahuanmu tentang rumah adat, tarian, lagu daerah, dan sejarah 15 wilayah kepulauan Indonesia.',
                      style: TextStyle(color: Color(0xFFECE0D8), fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade700,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      icon: const Icon(Icons.play_arrow_rounded, size: 26),
                      label: const Text(
                        'Mulai Petualangan',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => _navigateTo(const MapScreen()),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Grid Menu Eksplorasi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Menu Eksplorasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.35,
                    children: [
                      _buildMenuCard(
                        context,
                        title: 'Peta Nusantara',
                        subtitle: '15 Wilayah Pulau',
                        icon: Icons.map_rounded,
                        color: const Color(0xFFC86400),
                        onTap: () => _navigateTo(const MapScreen()),
                      ),
                      _buildMenuCard(
                        context,
                        title: 'Koleksi Reward',
                        subtitle: 'Lencana & Koin',
                        icon: Icons.emoji_events_rounded,
                        color: const Color(0xFFB8860B),
                        onTap: () => _navigateTo(const RewardScreen()),
                      ),
                      _buildMenuCard(
                        context,
                        title: 'Ensiklopedia',
                        subtitle: 'Budaya 15 Wilayah',
                        icon: Icons.menu_book_rounded,
                        color: darkBrown,
                        onTap: () => _showEncyclopediaDialog(context),
                      ),
                      _buildMenuCard(
                        context,
                        title: 'Panduan Game',
                        subtitle: 'Cara Bermain',
                        icon: Icons.help_outline_rounded,
                        color: const Color(0xFF2E7D32),
                        onTap: () => _showGuideDialog(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Kartu Misi Harian
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE0D5C8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.stars_rounded, color: Colors.amber, size: 30),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tantangan Hari Ini',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: darkBrown),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Selesaikan kuis di salah satu pulau untuk klaim koin Nusantara.',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: darkBrown),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEncyclopediaDialog(BuildContext context) {
    final List<Map<String, String>> cultureData = [
      {
        'island': '1. Pulau Sumatra',
        'house': 'Rumah Gadang (Minang), Rumah Bolon (Batak), Rumah Limas (Palembang)',
        'dance': 'Tari Piring, Tari Saman (Aceh), Tari Tor-Tor',
        'weapon': 'Rencong (Aceh), Kerambit (Minang)',
        'song': 'Bungong Jeumpa, Sinanggar Tulo, Kampuang Nan Far Di Mato',
      },
      {
        'island': '2. Kepulauan Riau & Babel',
        'house': 'Rumah Belah Bubung (Kepri), Rumah Rakit (Babel)',
        'dance': 'Tari Zapin, Tari Makan Sirih, Tari Campak',
        'weapon': 'Pedang Jenawi, Siwar',
        'song': 'Soleram, Zapin Laksamana Raja di Laut',
      },
      {
        'island': '3. Pulau Jawa',
        'house': 'Rumah Joglo (Jawa Tengah/Jogja), Rumah Baduy (Jabar)',
        'dance': 'Tari Reog Ponorogo, Tari Jaipong, Tari Serimpi',
        'weapon': 'Keris (Jawa), Kujang (Sunda)',
        'song': 'Gundul Pacul, Lir Ilir, Manuk Dadali',
      },
      {
        'island': '4. Pulau Madura',
        'house': 'Rumah Tanean Lanjang',
        'dance': 'Tari Topeng Gethak, Tari Othek',
        'weapon': 'Clurit',
        'song': 'Tanduk Majeng',
      },
      {
        'island': '5. Pulau Bali',
        'house': 'Areal Natah & Gapura Candi Bentar',
        'dance': 'Tari Kecak, Tari Pendet, Tari Legong',
        'weapon': 'Keris Bali',
        'song': 'Ratu Anom, Macepet-Cepetan',
      },
      {
        'island': '6. Nusa Tenggara Barat',
        'house': 'Bale Tani (Sasak Lombok), Dalam Loka (Sumbawa)',
        'dance': 'Tari Presean, Tari Lenggo',
        'weapon': 'Tulup / Sampari',
        'song': 'Kadal Nokake',
      },
      {
        'island': '7. Nusa Tenggara Timur',
        'house': 'Mbaru Niang (Wae Rebo), Rumah Musalaki',
        'dance': 'Tari Caci, Tari Kebalai, Tari Rangkuk Alu',
        'weapon': 'Sundu / Parang Taibeku',
        'song': 'Gemu Fa Mi Re, Anak Kambing Saya, Potong Bebek Angsa',
      },
      {
        'island': '8. Pulau Kalimantan',
        'house': 'Rumah Lamin / Radakng (Dayak), Rumah Bubungan Tinggi (Banjar)',
        'dance': 'Tari Enggang (Kancet Ledo), Tari Baksa Kembang',
        'weapon': 'Mandau, Sumpitan',
        'song': 'Ampar-Ampar Pisang, Cik Cik Periuk, Paris Barantai',
      },
      {
        'island': '9. Pulau Sulawesi',
        'house': 'Rumah Tongkonan (Toraja), Rumah Boyang (Mandar), Walewangko (Minahasa)',
        'dance': 'Tari Kipas Pakarena, Tari Maengket',
        'weapon': 'Badik (Bugis/Makassar)',
        'song': 'Angin Mammiri, Si Patokaan, O Ina Ni Keke',
      },
      {
        'island': '10. Kepulauan Sangir & Talaud',
        'house': 'Rumah Walewangko Sangihe',
        'dance': 'Tari Gunde, Tari Salo',
        'weapon': 'Bara / Bara Sangihe',
        'song': 'Sangiheang',
      },
      {
        'island': '11. Kepulauan Maluku',
        'house': 'Rumah Baileo',
        'dance': 'Tari Cakalele, Tari Lenso',
        'weapon': 'Salawaku, Parang Maluku',
        'song': 'Rasa Sayange, Burung Kakatua, Buka Pintu',
      },
      {
        'island': '12. Pulau Halmahera',
        'house': 'Rumah Sasadu',
        'dance': 'Tari Soya-Soya, Tari Laka Bula',
        'weapon': 'Barakosta / Parang Salawaku',
        'song': 'Borero',
      },
      {
        'island': '13. Pulau Papua',
        'house': 'Rumah Honai, Rumah Ebai',
        'dance': 'Tari Yospan, Tari Selamat Datang Asmat',
        'weapon': 'Busur & Panah, Belati Tulang Kasuari',
        'song': 'Yamko Rambe Yamko, Apuse, Sajojo',
      },
      {
        'island': '14. Pulau Biak & Yapen',
        'house': 'Rumah Rumsram',
        'dance': 'Tari Yospan, Tari Suling Bambu',
        'weapon': 'Tombak Ikan (Kalawai)',
        'song': 'Wong Kinar',
      },
      {
        'island': '15. Kepulauan Aru & Tanimbar',
        'house': 'Rumah Perahu Tanimbar',
        'dance': 'Tari Ngang, Tari Cendrawasih Aru',
        'weapon': 'Parang Aru & Busur',
        'song': 'Sikat Kasa',
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.menu_book_rounded, color: darkBrown),
            SizedBox(width: 8),
            Text(
              'Ensiklopedia 15 Wilayah',
              style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 420,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: cultureData.length,
            itemBuilder: (context, index) {
              final item = cultureData[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0D5C8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['island']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: darkBrown),
                    ),
                    const Divider(height: 12),
                    _buildInfoRow(Icons.home_rounded, 'Rumah:', item['house']!),
                    _buildInfoRow(Icons.accessibility_new_rounded, 'Tarian:', item['dance']!),
                    _buildInfoRow(Icons.verified_user_rounded, 'Senjata:', item['weapon']!),
                    _buildInfoRow(Icons.music_note_rounded, 'Lagu:', item['song']!),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup', style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: mediumBrown),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: darkBrown)),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  void _showGuideDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Panduan Permainan', style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold)),
        content: const Text(
          '1. Pilih wilayah pada Peta Nusantara.\n'
          '2. Pelajari ringkasan materi kebudayaan daerah.\n'
          '3. Jawab 20 kuis acak dengan tepat.\n'
          '4. Raih hingga 3 Bintang & Koin Nusantara.\n'
          '5. Kumpulkan koin untuk membuka lencana kebudayaan!',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup', style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}