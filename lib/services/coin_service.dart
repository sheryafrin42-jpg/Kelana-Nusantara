import 'package:shared_preferences/shared_preferences.dart';

class CoinService {
  static const String _coinKey = 'user_global_coins';

  // Membaca koin tersimpan dari memori HP
  static Future<int> getCoins() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_coinKey) ?? 0;
  }

  // Menyimpan koin baru ke memori HP
  static Future<void> saveCoins(int coins) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_coinKey, coins);
  }

  // Menambahkan koin kuis dan langsung menyimpannya secara permanen
  static Future<int> addCoins(int amount) async {
    int currentCoins = await getCoins();
    int newTotal = currentCoins + amount;
    await saveCoins(newTotal);
    return newTotal;
  }
}