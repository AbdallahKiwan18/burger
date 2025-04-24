import 'dart:convert';

import 'package:http/http.dart' as http;

class SubmissionService {
  static Future<void> submitAnswers(Map<String, dynamic> answers) async {
    final url = Uri.parse(
        'https://script.google.com/macros/s/AKfycbzBr0rOsvTtm1Qn737p2qL1Ze1CzTo0Wc6ZYEbYKXJSpahRGS7dNU-Il2bm44pL268BxA/exec');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(answers),
    );

    if (response.statusCode != 200) {
      throw Exception('فشل في إرسال البيانات ');
    }
  }
}
