// Login tugmasi ichida:
onPressed: () async {
  final result = await AuthService().login(emailController.text, passwordController.text);
  
  if (result['success']) {
    // Muvaffaqiyatli kirsa, Dashboardga o'tamiz
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => DashboardScreen())
    );
  } else {
    // Xato bo'lsa, xabar chiqaramiz
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
    );
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = "http://SIZNING_SERVER_IP:8000"; // Server manzili
  final _storage = FlutterSecureStorage();

  // 1. JWT tokenni Headerga qo'shish
  Future<Map<String, String>> _getHeaders() async {
    String? token = await _storage.read(key: "jwt_token");
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  // 2. Dashboard ma'lumotlarini olish
  Future<Map<String, dynamic>> fetchDashboard(int userId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/dashboard/$userId"),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Ma'lumotlarni yuklashda xatolik");
    }
  }

  // 3. Payme to'lov havolasini olish
  Future<String> getPaymeLink(double amount) async {
    final response = await http.post(
      Uri.parse("$baseUrl/pay/create"),
      headers: await _getHeaders(),
      body: json.encode({"sum": amount}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['pay_url'];
    } else {
      throw Exception("To'lov havolasini olish imkonsiz");
    }
  }
}
