import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KelanaNusantaraApp());
}

class KelanaNusantaraApp extends StatefulWidget {
  const KelanaNusantaraApp({super.key});

  @override
  State<KelanaNusantaraApp> createState() => _KelanaNusantaraAppState();
}

class _KelanaNusantaraAppState extends State<KelanaNusantaraApp> with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;
  bool _isPlayerInitialized = false;

  @override
  void initState() {
    super.initState();
    // Daftarkan observer untuk memantau siklus hidup aplikasi (minimize/close)
    WidgetsBinding.instance.addObserver(this);
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
  }

  void _playBackgroundMusic() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(0.4);
      await _audioPlayer.play(AssetSource('audio/gamelan-background-music-307716.mp3'));
      _isPlayerInitialized = true;
    } catch (e) {
      debugPrint('Gagal memutar audio: $e');
    }
  }

  // Mengontrol pemutaran musik berdasarkan kondisi aplikasi (Minimized / Closed / Resumed)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isPlayerInitialized) return;

    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // Hentikan/Jeda musik saat aplikasi di-minimize atau ditutup
      _audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      // Lanjutkan musik saat aplikasi dibuka kembali
      _audioPlayer.resume();
    }
  }

  @override
  void dispose() {
    // Hapus observer siklus hidup
    WidgetsBinding.instance.removeObserver(this);
    // Hentikan dan bersihkan pemutar audio dari memori
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kelana Nusantara',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFFDFBF7),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}