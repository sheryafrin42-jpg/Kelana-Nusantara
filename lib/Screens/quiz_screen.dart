import 'dart:math';
import 'package:flutter/material.dart';
import '../services/coin_service.dart';
import 'quiz_review_screen.dart';

class QuizScreen extends StatefulWidget {
  final String islandName;

  const QuizScreen({super.key, required this.islandName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _isAnswered = false;

  late List<Map<String, dynamic>> _questions;
  final List<Map<String, dynamic>> _userHistory = [];

  static const Color darkBrown = Color(0xFF4A2511);
  static const Color mediumBrown = Color(0xFF6A3516);
  static const Color warmCream = Color(0xFFF9F5EC);

  @override
  void initState() {
    super.initState();
    List<Map<String, dynamic>> fullBank = _getBankForIsland(widget.islandName);
    fullBank.shuffle(Random());
    // Mengambil 20 soal penuh per kuis
    _questions = fullBank.take(min(20, fullBank.length)).toList();
  }

  List<Map<String, dynamic>> _getBankForIsland(String island) {
    String lower = island.toLowerCase();

    if (lower.contains('sumatra')) {
      return [
        {'question': 'Rumah adat khas Minangkabau di Sumatra Barat dinamakan...', 'options': ['Rumah Gadang', 'Rumah Limas', 'Rumah Bolon', 'Rumah Kebaya', 'Rumah Joglo'], 'answer': 0},
        {'question': 'Tari Piring merupakan tarian tradisional asal daerah...', 'options': ['Aceh', 'Sumatra Barat', 'Sumatra Utara', 'Riau', 'Jambi'], 'answer': 1},
        {'question': 'Kain tenun tradisional khas Batak di Sumatra Utara adalah...', 'options': ['Songket', 'Batik', 'Ulos', 'Sasirangan', 'Tais'], 'answer': 2},
        {'question': 'Tari Saman yang terkenal dengan keharmonisan gerakannya berasal dari...', 'options': ['Riau', 'Jambi', 'Lampung', 'Aceh', 'Bengkulu'], 'answer': 3},
        {'question': 'Danau vulkanik terbesar di Indonesia di Sumatra Utara adalah...', 'options': ['Danau Maninjau', 'Danau Singkarak', 'Danau Ranau', 'Danau Diatas', 'Danau Toba'], 'answer': 4},
        {'question': 'Senjata tradisional khas suku Aceh dinamakan...', 'options': ['Rencong', 'Keris', 'Badik', 'Mandau', 'Kujang'], 'answer': 0},
        {'question': 'Rumah adat suku Batak di Sumatra Utara dinamakan...', 'options': ['Rumah Gadang', 'Rumah Bolon', 'Rumah Panggung', 'Rumah Limas', 'Rumah Honai'], 'answer': 1},
        {'question': 'Rumah adat khas Sumatra Selatan dinamakan...', 'options': ['Rumah Gadang', 'Nuwo Sesat', 'Rumah Limas', 'Bubungan Lima', 'Rumah Banjar'], 'answer': 2},
        {'question': 'Rumah adat khas daerah Lampung dinamakan...', 'options': ['Rumah Limas', 'Rumah Bolon', 'Rumah Gadang', 'Nuwo Sesat', 'Rumah Kebaya'], 'answer': 3},
        {'question': 'Kain mewah khas Palembang hasil tenunan benang emas adalah...', 'options': ['Kain Ulos', 'Kain Batik', 'Kain Tais', 'Kain Sasirangan', 'Kain Songket'], 'answer': 4},
        {'question': 'Tari Tor-Tor merupakan tarian tradisional dari suku...', 'options': ['Batak', 'Minangkabau', 'Melayu', 'Nias', 'Aceh'], 'answer': 0},
        {'question': 'Alat musik petik khas suku Batak adalah...', 'options': ['Aramba', 'Hasapi', 'Saluang', 'Serunai', 'Angklung'], 'answer': 1},
        {'question': 'Alat musik tiup bambu khas Minangkabau mirip seruling dinamakan...', 'options': ['Aramba', 'Hasapi', 'Saluang', 'Kolintang', 'Tifa'], 'answer': 2},
        {'question': 'Seni teater tradisional khas Minangkabau adalah...', 'options': ['Ludruk', 'Ketoprak', 'Mak Yong', 'Randai', 'Lenong'], 'answer': 3},
        {'question': 'Senjata tradisional khas Minangkabau yang melengkung tajam adalah...', 'options': ['Rencong', 'Keris', 'Badik', 'Kujang', 'Kerambit'], 'answer': 4},
        {'question': 'Tradisi lompat batu yang sangat terkenal berasal dari pulau...', 'options': ['Nias', 'Mentawai', 'Bangka', 'Belitung', 'Samosir'], 'answer': 0},
        {'question': 'Lagu daerah Bungong Jeumpa berasal dari provinsi...', 'options': ['Sumatra Utara', 'Aceh', 'Riau', 'Jambi', 'Bengkulu'], 'answer': 1},
        {'question': 'Lagu daerah Sinanggar Tulo berasal dari provinsi...', 'options': ['Sumatra Barat', 'Aceh', 'Sumatra Utara', 'Riau', 'Lampung'], 'answer': 2},
        {'question': 'Lagu daerah Kampuang Nan Far Di Mato berasal dari...', 'options': ['Riau', 'Bengkulu', 'Sumatra Selatan', 'Sumatra Barat', 'Aceh'], 'answer': 3},
        {'question': 'Rumah adat khas Bengkulu dinamakan...', 'options': ['Rumah Gadang', 'Nuwo Sesat', 'Rumah Limas', 'Rumah Kebaya', 'Rumah Bubungan Lima'], 'answer': 4},
      ];
    } else if (lower.contains('riau') || lower.contains('babel')) {
      return [
        {'question': 'Tradisi lomba dayung perahu panjang khas Riau dinamakan...', 'options': ['Pacu Jalur', 'Karapan Sapi', 'Tabuik', 'Bau Nyale', 'Pasola'], 'answer': 0},
        {'question': 'Rumah adat khas Kepulauan Riau dinamakan...', 'options': ['Rumah Gadang', 'Rumah Belah Bubung', 'Rumah Limas', 'Rumah Rakit', 'Rumah Joglo'], 'answer': 1},
        {'question': 'Seni pertunjukan teater khas masyarakat Melayu Riau adalah...', 'options': ['Randai', 'Ketoprak', 'Mak Yong', 'Ludruk', 'Lenong'], 'answer': 2},
        {'question': 'Tari Zapin merupakan tarian pengaruh Arab khas suku...', 'options': ['Batak', 'Nias', 'Minang', 'Melayu', 'Bugis'], 'answer': 3},
        {'question': 'Senjata tradisional khas suku Melayu Riau adalah...', 'options': ['Rencong', 'Mandau', 'Kujang', 'Badik', 'Pedang Jenawi'], 'answer': 4},
        {'question': 'Rumah adat khas Kepulauan Bangka Belitung dinamakan...', 'options': ['Rumah Rakit', 'Rumah Gadang', 'Rumah Limas', 'Rumah Bolon', 'Rumah Joglo'], 'answer': 0},
        {'question': 'Lagu daerah Soleram berasal dari provinsi...', 'options': ['Aceh', 'Riau', 'Jambi', 'Lampung', 'Sumut'], 'answer': 1},
        {'question': 'Tarian khas Kepulauan Riau untuk menyambut tamu adalah...', 'options': ['Tari Saman', 'Tari Tor-Tor', 'Tari Makan Sirih', 'Tari Piring', 'Tari Kecak'], 'answer': 2},
        {'question': 'Alat musik perkusi khas suku Melayu Riau dinamakan...', 'options': ['Tifa', 'Angklung', 'Kolintang', 'Gendang Nobat', 'Sasando'], 'answer': 3},
        {'question': 'Tradisi perang ketupat diselenggarakan di provinsi...', 'options': ['Riau', 'Jambi', 'Sumbar', 'Lampung', 'Bangka Belitung'], 'answer': 4},
        {'question': 'Lagu daerah Zapin Laksamana Raja di Laut berasal dari...', 'options': ['Riau', 'Sumut', 'Lampung', 'Babel', 'Aceh'], 'answer': 0},
        {'question': 'Minuman tradisional khas Riau bernamakan unik adalah...', 'options': ['Bajigur', 'Laksamana Mengamuk', 'Es Pleret', 'Wedang Uwuh', 'Es Dawet'], 'answer': 1},
        {'question': 'Senjata khas Bangka Belitung yang berbentuk cangkul kecil adalah...', 'options': ['Keris', 'Badik', 'Siwar', 'Mandau', 'Rencong'], 'answer': 2},
        {'question': 'Tarian pergaulan khas masyarakat Bangka Belitung dinamakan...', 'options': ['Tari Piring', 'Tari Kecak', 'Tari Saman', 'Tari Campak', 'Tari Jaipong'], 'answer': 3},
        {'question': 'Alat musik gesek tradisional Melayu Riau dinamakan...', 'options': ['Gambus', 'Siter', 'Kecapi', 'Sape', 'Rebab'], 'answer': 4},
        {'question': 'Kain tenun khas masyarakat Melayu Riau adalah...', 'options': ['Samping Melayu / Songket', 'Ulos', 'Batik', 'Sasirangan', 'Tais'], 'answer': 0},
        {'question': 'Cagar budaya benteng bersejarah di Kepulauan Riau adalah...', 'options': ['Benteng Rotterdam', 'Benteng Bukit Kursi', 'Benteng Marlborough', 'Benteng Vredeburg', 'Benteng Kuto Besak'], 'answer': 1},
        {'question': 'Cerita rakyat terkenal asal Bangka Belitung adalah...', 'options': ['Malin Kundang', 'Roro Jonggrang', 'Penyumpitan', 'Danau Toba', 'Sangkuriang'], 'answer': 2},
        {'question': 'Kuliner khas Bangka Belitung dari bahan dasar hasil laut adalah...', 'options': ['Pempek', 'Rendang', 'Gudeg', 'Lempah Kuning', 'Sate Maranggi'], 'answer': 3},
        {'question': 'Pakaian adat pria khas Melayu Riau dinamakan...', 'options': ['Baju Bodo', 'Baju Pesa\'an', 'Kebaya', 'Beskap', 'Baju Kurung Cekak Musang'], 'answer': 4},
      ];
    } else if (lower.contains('jawa')) {
      return [
        {'question': 'Apa nama rumah tradisional khas Yogyakarta dan Jawa Tengah?', 'options': ['Rumah Joglo', 'Rumah Gadang', 'Rumah Honai', 'Rumah Kebaya', 'Rumah Limas'], 'answer': 0},
        {'question': 'Alat musik tradisional khas Jawa Barat dari bambu adalah...', 'options': ['Sasando', 'Angklung', 'Kolintang', 'Gamelan', 'Tifa'], 'answer': 1},
        {'question': 'Candi Buddha terbesar di dunia di Jawa Tengah adalah...', 'options': ['Candi Prambanan', 'Candi Dieng', 'Candi Borobudur', 'Candi Sewu', 'Candi Mendut'], 'answer': 2},
        {'question': 'Tarian khas Ponorogo dengan topeng singa dan merak adalah...', 'options': ['Tari Jaipong', 'Tari Kecak', 'Tari Piring', 'Tari Reog', 'Tari Serimpi'], 'answer': 3},
        {'question': 'Kain khas Indonesia diakui UNESCO asal Jawa adalah...', 'options': ['Kain Ulos', 'Kain Songket', 'Kain Sasirangan', 'Kain Tais', 'Batik'], 'answer': 4},
        {'question': 'Seni pertunjukan bayangan kulit khas Jawa dinamakan...', 'options': ['Wayang Kulit', 'Wayang Golek', 'Ketoprak', 'Ludruk', 'Lenong'], 'answer': 0},
        {'question': 'Senjata tradisional khas suku Jawa berlekuk-lekuk adalah...', 'options': ['Rencong', 'Keris', 'Kujang', 'Mandau', 'Badik'], 'answer': 1},
        {'question': 'Alat musik petik khas Sunda dinamakan...', 'options': ['Siter', 'Gambus', 'Kecapi', 'Sape', 'Sasando'], 'answer': 2},
        {'question': 'Senjata tradisional khas masyarakat Jawa Barat/Sunda adalah...', 'options': ['Mandau', 'Badik', 'Keris', 'Kujang', 'Rencong'], 'answer': 3},
        {'question': 'Tari tradisional berenergi khas Sunda adalah...', 'options': ['Tari Serimpi', 'Tari Bedhaya', 'Tari Kecak', 'Tari Saman', 'Tari Jaipong'], 'answer': 4},
        {'question': 'Candi Hindu terbesar di Indonesia yang terletak di Sleman adalah...', 'options': ['Candi Prambanan', 'Candi Sewu', 'Candi Penataran', 'Candi Dieng', 'Candi Borobudur'], 'answer': 0},
        {'question': 'Gamelan khas Jawa Tengah umumnya dimainkan dengan nada...', 'options': ['Diatonis', 'Pelog dan Slendro', 'Mayor dan Minor', 'Pentatonis Barat', 'Kromatis'], 'answer': 1},
        {'question': 'Tarian klasik keraton Yogyakarta dan Surakarta adalah...', 'options': ['Tari Kecak', 'Tari Piring', 'Tari Serimpi', 'Tari Jaipong', 'Tari Tor-Tor'], 'answer': 2},
        {'question': 'Suku asli yang mendiami pedalaman Banten adalah...', 'options': ['Suku Samin', 'Suku Tengger', 'Suku Osing', 'Suku Baduy', 'Suku Dayak'], 'answer': 3},
        {'question': 'Suku adat yang tinggal di kawasan Gunung Bromo Jawa Timur adalah...', 'options': ['Suku Osing', 'Suku Madura', 'Suku Baduy', 'Suku Samin', 'Suku Tengger'], 'answer': 4},
        {'question': 'Kesenian teater rakyat tradisional khas Jawa Tengah dinamakan...', 'options': ['Ketoprak', 'Ludruk', 'Randai', 'Mak Yong', 'Lenong'], 'answer': 0},
        {'question': 'Minuman tradisional khas Solo dan Jogja dari rempah-rempah adalah...', 'options': ['Es Selendang Mayang', 'Wedang Uwuh', 'Bajigur', 'Es Pleret', 'Bir Pletok'], 'answer': 1},
        {'question': 'Lagu daerah Jawa Tengah yang menceritakan tentang gundul pacul adalah...', 'options': ['Lir Ilir', 'Suwe Ora Jamu', 'Gundul Pacul', 'Manuk Dadali', 'Bubuy Bulan'], 'answer': 2},
        {'question': 'Lagu daerah Sunda yang terkenal menceritakan burung adalah...', 'options': ['Bubuy Bulan', 'Tokecang', 'Es Lilin', 'Manuk Dadali', 'Kicir-Kicir'], 'answer': 3},
        {'question': 'Wayang kayu khas Jawa Barat dinamakan...', 'options': ['Wayang Beber', 'Wayang Orang', 'Wayang Kulit', 'Wayang Sasak', 'Wayang Golek'], 'answer': 4},
      ];
    } else if (lower.contains('madura')) {
      return [
        {'question': 'Senjata tradisional khas masyarakat Madura adalah...', 'options': ['Clurit', 'Keris', 'Kujang', 'Mandau', 'Badik'], 'answer': 0},
        {'question': 'Tradisi balapan sapi yang sangat terkenal di Madura dinamakan...', 'options': ['Pacu Jalur', 'Karapan Sapi', 'Lompat Batu', 'Bau Nyale', 'Pasola'], 'answer': 1},
        {'question': 'Pakaian adat khas pria Madura bercorak garis merah putih adalah...', 'options': ['Baju Bodo', 'Kebaya', 'Baju Pesa\'an', 'Beskap', 'Baju Kurung'], 'answer': 2},
        {'question': 'Kesenian tari topeng tradisional khas Madura dinamakan...', 'options': ['Tari Reog', 'Tari Jaipong', 'Tari Piring', 'Tari Topeng Gethak', 'Tari Saman'], 'answer': 3},
        {'question': 'Musik tradisional khas Madura yang menggunakan saron dinamakan...', 'options': ['Gamelan', 'Kolintang', 'Angklung', 'Tifa', 'Musik Saronen'], 'answer': 4},
        {'question': 'Kain batik khas Madura terkenal dengan warna...', 'options': ['Cerah & Berani', 'Gelap Pucat', 'Hitam Polos', 'Putih Pucat', 'Abu-Abu'], 'answer': 0},
        {'question': 'Suku asli penghuni Pulau Madura adalah...', 'options': ['Suku Tengger', 'Suku Madura', 'Suku Osing', 'Suku Baduy', 'Suku Bugis'], 'answer': 1},
        {'question': 'Kuliner olahan sate khas Madura bumbu kacang dinamakan...', 'options': ['Sate Maranggi', 'Sate Lilit', 'Sate Madura', 'Sate Padang', 'Sate Buntel'], 'answer': 2},
        {'question': 'Lagu daerah Madura yang terkenal adalah...', 'options': ['Gundul Pacul', 'Cik Cik Periuk', 'Ampar Pisang', 'Tanduk Majeng', 'Soleram'], 'answer': 3},
        {'question': 'Upacara adat ritual syukuran nelayan di Madura dinamakan...', 'options': ['Ngaben', 'Tabuik', 'Bau Nyale', 'Tiwah', 'Rokatan Tasi\''], 'answer': 4},
        {'question': 'Rumah adat tradisional khas masyarakat Madura dinamakan...', 'options': ['Tanean Lanjang', 'Rumah Joglo', 'Rumah Limas', 'Rumah Gadang', 'Honai'], 'answer': 0},
        {'question': 'Batu mulia & bahan tambang terkenal dari Madura berada di kawasan...', 'options': ['Bangkalan', 'Sumenep', 'Sampang', 'Pamekasan', 'Gresik'], 'answer': 1},
        {'question': 'Jembatan terpanjang penghubung Surabaya dan Madura adalah...', 'options': ['Jembatan Ampera', 'Jembatan Barelang', 'Jembatan Suramadu', 'Jembatan Kutai', 'Jembatan Merah Putih'], 'answer': 2},
        {'question': 'Cerita rakyat Madura yang legendaris tentang kesaktian adalah...', 'options': ['Sakera', 'Kancil', 'Sangkuriang', 'Jokotole', 'Malin Kundang'], 'answer': 3},
        {'question': 'Tokoh pahlawan lokal pemberani khas masyarakat Madura adalah...', 'options': ['Si Pitung', 'Pangeran Diponegoro', 'Pattimura', 'Sisingamangaraja', 'Sakera'], 'answer': 4},
        {'question': 'Tarian ritual mamuji syukuran hujan di Madura dinamakan...', 'options': ['Tari Othek', 'Tari Kecak', 'Tari Saman', 'Tari Piring', 'Tari Jaipong'], 'answer': 0},
        {'question': 'Olahraga bela diri khas Madura dengan tongkat jalinan adalah...', 'options': ['Caci', 'Pencak Silat Khas Madura', 'Tarung Derajat', 'Karate', 'Pencak Dor'], 'answer': 1},
        {'question': 'Seni pertunjukan teater tutur khas Madura dinamakan...', 'options': ['Ketoprak', 'Ludruk', 'Macapat Madura', 'Randai', 'Mak Yong'], 'answer': 2},
        {'question': 'Keraton bersejarah yang berdiri di Pulau Madura berada di...', 'options': ['Keraton Jogja', 'Keraton Solo', 'Keraton Cirebon', 'Keraton Sumenep', 'Keraton Kutai'], 'answer': 3},
        {'question': 'Tumbuhan buah khas Madura berukuran besar adalah...', 'options': ['Durian', 'Mangga', 'Pisang', 'Jeruk', 'Salak Bangkalan'], 'answer': 4},
      ];
    } else if (lower.contains('bali')) {
      return [
        {'question': 'Tari ritual tradisional yang sangat terkenal dari Bali adalah...', 'options': ['Tari Kecak', 'Tari Pendet', 'Tari Barong', 'Tari Legong', 'Tari Saman'], 'answer': 0},
        {'question': 'Tari penyambutan tamu khas Bali dinamakan...', 'options': ['Tari Kecak', 'Tari Pendet', 'Tari Legong', 'Tari Barong', 'Tari Piring'], 'answer': 1},
        {'question': 'Upacara adat pembakaran jenazah di Bali dinamakan...', 'options': ['Rambu Solo', 'Tiwah', 'Ngaben', 'Tabuik', 'Kasada'], 'answer': 2},
        {'question': 'Sistem irigasi pertanian tradisional Bali diakui UNESCO dinamakan...', 'options': ['Sengkedan', 'Terasering', 'Reboisasi', 'Subak', 'Pariwisata'], 'answer': 3},
        {'question': 'Senjata tradisional khas suku Bali adalah...', 'options': ['Rencong', 'Mandau', 'Kujang', 'Badik', 'Keris Bali'], 'answer': 4},
        {'question': 'Kesenian drama tarian bertopeng mitologi Bali adalah...', 'options': ['Tari Barong & Rangda', 'Tari Kecak', 'Tari Topeng', 'Tari Legong', 'Tari Pendet'], 'answer': 0},
        {'question': 'Tari klasik Bali yang dibawakan oleh penari putri adalah...', 'options': ['Tari Kecak', 'Tari Legong', 'Tari Barong', 'Tari Saman', 'Tari Jaipong'], 'answer': 1},
        {'question': 'Hari Raya penyucian dan hening bagi umat Hindu Bali dinamakan...', 'options': ['Galungan', 'Kuningan', 'Hari Raya Nyepi', 'Saraswati', 'Pagerwesi'], 'answer': 2},
        {'question': 'Hari Raya memperingati kemenangan Dharma melawan Adharma di Bali adalah...', 'options': ['Nyepi', 'Saraswati', 'Pagerwesi', 'Galungan', 'Kuningan'], 'answer': 3},
        {'question': 'Pura laut terkenal di Bali yang berdiri di atas batu karang adalah...', 'options': ['Pura Besakih', 'Pura Uluwatu', 'Pura Ulun Danu', 'Pura Tirta Empul', 'Pura Tanah Lot'], 'answer': 4},
        {'question': 'Pura terbesar dan pusat tempat ibadah di Bali adalah...', 'options': ['Pura Besakih', 'Pura Tanah Lot', 'Pura Ulun Danu', 'Pura Uluwatu', 'Pura Lempuyang'], 'answer': 0},
        {'question': 'Desa adat di Bali yang terkenal dengan tradisi pemakaman terbuka adalah...', 'options': ['Desa Penglipuran', 'Desa Trunyan', 'Desa Ubud', 'Desa Sukawati', 'Desa Kintamani'], 'answer': 1},
        {'question': 'Desa paling bersih di Bali yang mempertahankan arsitektur bambu adalah...', 'options': ['Desa Trunyan', 'Desa Sukawati', 'Desa Penglipuran', 'Desa Sanur', 'Desa Legian'], 'answer': 2},
        {'question': 'Alat musik Gamelan khas Bali memiliki ciri nada...', 'options': ['Lebih lambat', 'Sama dengan Jawa', 'Monoton', 'Lebih cepat & dinamis', 'Diatonis'], 'answer': 3},
        {'question': 'Pakaian adat pria Bali lengkap dengan penutup kepala dinamakan...', 'options': ['Blangkon', 'Peci', 'Topi', 'Songkok', 'Udeng'], 'answer': 4},
        {'question': 'Kain penutup badan khas Bali berkotak-kotak hitam putih dinamakan...', 'options': ['Kain Poleng', 'Kain Batik', 'Kain Songket', 'Kain Ulos', 'Kain Sasirangan'], 'answer': 0},
        {'question': 'Rumah adat tradisional masyarakat Bali dinamakan...', 'options': ['Joglo', 'Gapura Candi Bentar / Areal Natah', 'Honai', 'Tongkonan', 'Gadang'], 'answer': 1},
        {'question': 'Lagu daerah Bali yang menceritakan tentang bunga adalah...', 'options': ['Macepet-Cepetan', 'Meong-Meong', 'Ratu Anom', 'Bungong Jeumpa', 'Soleram'], 'answer': 2},
        {'question': 'Patung raksasa ikonik Bali karya Nyoman Nuarta adalah...', 'options': ['Monas', 'Patung Dirgantara', 'Patung Suroboyo', 'GWK (Garuda Wisnu Kencana)', 'Patung Pemuda'], 'answer': 3},
        {'question': 'Kuliner khas Bali berpenggalan rempah pedas dinamakan...', 'options': ['Rendang', 'Gudeg', 'Soto', 'Pempek', 'Ayam Betutu'], 'answer': 4},
      ];
    } else {
      // Berlaku untuk wilayah lainnya (NTB, NTT, Kalimantan, Sulawesi, Sangir/Talaud, Halmahera, Biak/Yapen, Tanimbar/Aru, Maluku, Papua)
      return [
        {'question': 'Rumah adat Papua berbentuk bundar beratap jerami dinamakan...', 'options': ['Rumah Honai', 'Rumah Lamin', 'Rumah Tongkonan', 'Rumah Joglo', 'Rumah Gadang'], 'answer': 0},
        {'question': 'Alat musik ritmis khas Papua dan Maluku yang dipukul adalah...', 'options': ['Kendang', 'Tifa', 'Rebana', 'Angklung', 'Gamelan'], 'answer': 1},
        {'question': 'Tas anyaman serat kayu khas Papua diakui UNESCO dinamakan...', 'options': ['Koja', 'Anjat', 'Noken', 'Keranjang', 'Ransel'], 'answer': 2},
        {'question': 'Senjata tradisional khas suku Papua adalah...', 'options': ['Mandau', 'Keris', 'Rencong', 'Busur dan Panah', 'Kujang'], 'answer': 3},
        {'question': 'Senjata belati tradisional Papua terbuat dari tulang...', 'options': ['Tulang Sapi', 'Tulang Ikan', 'Tulang Harimau', 'Tulang Ular', 'Tulang Burung Kasuari'], 'answer': 4},
        {'question': 'Tari persahabatan dan gembira khas Papua dinamakan...', 'options': ['Tari Yospan', 'Tari Cakalele', 'Tari Piring', 'Tari Saman', 'Tari Kecak'], 'answer': 0},
        {'question': 'Suku di Papua yang terkenal mahir dalam seni ukir kayu adalah...', 'options': ['Suku Dani', 'Suku Asmat', 'Suku Biak', 'Suku Sentani', 'Suku Serui'], 'answer': 1},
        {'question': 'Kepulauan surga bawah laut terkenal di Papua Barat adalah...', 'options': ['Bunaken', 'Wakatobi', 'Raja Ampat', 'Derawan', 'Togean'], 'answer': 2},
        {'question': 'Upacara adat bakar batu di Papua bertujuan untuk...', 'options': ['Upacara Pemakaman', 'Menyambut Hujan', 'Pesta Perang', 'Syukuran & Perdamaian', 'Ritual Berburu'], 'answer': 3},
        {'question': 'Lagu daerah Papua tentang perpisahan yang sangat syahdu dinamakan...', 'options': ['Yamko Rambe', 'Sajojo', 'Bungong Jeumpa', 'Soleram', 'Apuse'], 'answer': 4},
        {'question': 'Rumah adat suku Toraja di Sulawesi Selatan dinamakan...', 'options': ['Rumah Tongkonan', 'Rumah Boyang', 'Rumah Walewangko', 'Rumah Honai', 'Rumah Joglo'], 'answer': 0},
        {'question': 'Alat musik petik khas NTT berbahan daun lontar dinamakan...', 'options': ['Sape', 'Sasando', 'Ukulele', 'Kecapi', 'Angklung'], 'answer': 1},
        {'question': 'Alat musik petik tradisional Dayak Kalimantan adalah...', 'options': ['Sasando', 'Kecapi', 'Sape', 'Siter', 'Gitar'], 'answer': 2},
        {'question': 'Senjata tradisional khas suku Dayak Kalimantan adalah...', 'options': ['Rencong', 'Badik', 'Keris', 'Mandau', 'Kujang'], 'answer': 3},
        {'question': 'Danau tiga warna yang terkenal di Flores NTT berada di puncak...', 'options': ['Gunung Rinjani', 'Gunung Tambora', 'Gunung Bromo', 'Gunung Agung', 'Gunung Kelimutu'], 'answer': 4},
        {'question': 'Suku asli yang mendiami Pulau Lombok NTB adalah...', 'options': ['Suku Sasak', 'Suku Mbojo', 'Suku Sumbawa', 'Suku Bugis', 'Suku Dayak'], 'answer': 0},
        {'question': 'Kapal layar tradisional khas Suku Bugis Makassar adalah...', 'options': ['Kapal Cadik', 'Kapal Pinisi', 'Lancang Kuning', 'Kapal Perang', 'Kapal Motor'], 'answer': 1},
        {'question': 'Upacara pemakaman adat suku Toraja yang terkenal dinamakan...', 'options': ['Ngaben', 'Tiwah', 'Rambu Solo', 'Tabuik', 'Kasada'], 'answer': 2},
        {'question': 'Lagu tarian massal modern terkenal khas Maumere NTT dinamakan...', 'options': ['Anak Kambing Saya', 'Potong Bebek Angsa', 'Apuse', 'Gemu Fa Mi Re', 'Sajojo'], 'answer': 3},
        {'question': 'Kadal raksasa purba endemik di Pulau Komodo NTT dinamakan...', 'options': ['Biawak', 'Iguana', 'Buaya', 'Ular', 'Komodo'], 'answer': 4},
      ];
    }
  }

  void _answerQuestion(int index) {
    if (_isAnswered) return;

    final currentQuestion = _questions[_currentQuestionIndex];
    bool isCorrect = index == currentQuestion['answer'];

    setState(() {
      _selectedOption = index;
      _isAnswered = true;
    });

    if (isCorrect) {
      _score += 20;
    }

    _userHistory.add({
      'question': currentQuestion['question'],
      'options': currentQuestion['options'],
      'selectedAnswer': index,
      'correctAnswer': currentQuestion['answer'],
      'isCorrect': isCorrect,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? 'Jawaban Benar! (+20 Poin)' : 'Jawaban Kurang Tepat!'),
        duration: const Duration(milliseconds: 800),
        backgroundColor: isCorrect ? Colors.green[700] : Colors.red[700],
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedOption = null;
          _isAnswered = false;
        });
      } else {
        _showRewardDialog();
      }
    });
  }

  void _showRewardDialog() async {
    if (_score > 0) {
      await CoinService.addCoins(_score);
    }

    int stars = 1;
    String title = 'Bagus!';
    if (_score >= 320) {
      stars = 3;
      title = 'Luar Biasa, Penjelajah Sejati!';
    } else if (_score >= 240) {
      stars = 2;
      title = 'Hebat!';
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, color: darkBrown),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Icon(
                    index < stars ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: Colors.amber,
                    size: 45,
                  );
                }),
              ),
              const SizedBox(height: 12),
              const Text('Hadiah Kelana:', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        '+$_score Koin Nusantara',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: darkBrown,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBrown,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              icon: const Icon(Icons.history_rounded),
              label: const Text('Cek Riwayat Jawaban'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizReviewScreen(
                      userAnswers: _userHistory,
                      totalScore: _score,
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

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: warmCream,
        appBar: AppBar(
          title: Text('Kuis ${widget.islandName}', style: const TextStyle(color: Colors.white)),
          backgroundColor: darkBrown,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Center(
          child: CircularProgressIndicator(color: darkBrown),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: warmCream,
      appBar: AppBar(
        title: Text(
          'Kuis ${widget.islandName}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkBrown,
        elevation: 2,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          tooltip: 'Keluar Kuis',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Keluar dari Kuis?'),
                content: const Text('Progres kuis saat ini tidak akan disimpan.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Keluar',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A2511), Color(0xFF6A3516), Color(0xFFF9F5EC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.28, 0.75],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              children: [
                // Header Status Progress Soal & Koin
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.quiz_rounded, color: mediumBrown, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Soal ${_currentQuestionIndex + 1} dari ${_questions.length}',
                                style: const TextStyle(
                                  color: darkBrown,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8E7),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.amber, width: 1.5),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.monetization_on_rounded, color: Colors.amber, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  '$_score Poin',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: darkBrown,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: (_currentQuestionIndex + 1) / _questions.length,
                          minHeight: 10,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Kartu Pertanyaan Etnik Berbingkai Emas
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.amber.shade700, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: darkBrown.withValues(alpha: 0.18),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: const BoxDecoration(
                          color: darkBrown,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.menu_book_rounded, color: Colors.amber, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Kebudayaan ${widget.islandName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Text(
                          currentQuestion['question'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: darkBrown,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // List Opsi Pilihan Jawaban A / B / C / D / E
                Column(
                  children: List.generate(
                    (currentQuestion['options'] as List).length,
                    (index) {
                      final isSelected = _selectedOption == index;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected ? mediumBrown : Colors.white,
                            foregroundColor: isSelected ? Colors.white : darkBrown,
                            side: BorderSide(
                              color: isSelected ? darkBrown : const Color(0xFFD4C4B4),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                            elevation: isSelected ? 4 : 2,
                          ),
                          onPressed: () => _answerQuestion(index),
                          child: Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.amber : const Color(0xFFFFF8E7),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? Colors.white : Colors.amber.shade700,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + index),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: isSelected ? darkBrown : mediumBrown,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  currentQuestion['options'][index],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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
          ),
        ),
      ),
    );
  }
}