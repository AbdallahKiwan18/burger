import 'dart:convert';

import 'package:http/http.dart' as http;

class SubmissionService {
  static Future<void> submitAnswers(Map<String, dynamic> answers) async {
    final url = Uri.parse(
        'https://script.google.com/macros/s/AKfycbzLE0Smf8Q7uC4I-bRD3OMyKX-pcFhnrfZpwV6idbtzGx0E2XilP3csUHONlJnVApT0rQ/exec');
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
