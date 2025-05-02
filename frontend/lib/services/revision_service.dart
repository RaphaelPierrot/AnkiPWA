import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RevisionService {
  static final _base = dotenv.env['API_BASE_URL']!; // jamais null en prod
  static Future<void> submitCardResult({
    required String cardId,
    required int quality,
  }) async {
    final url = Uri.parse('$_base/submit/$cardId'); // à adapter

    await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: '{"quality": $quality}',
    );
  }
}
