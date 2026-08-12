import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  // Android Emulator → Windows computer
  //static const String baseUrl = 'http://10.0.2.2:5000';

  // If you run Flutter Web on Chrome, use:
  static const String baseUrl = 'http://127.0.0.1:5000';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data['response'] ?? 'I am here to listen.';
      }

      return 'I am having trouble connecting right now. Please try again.';
    } catch (e) {
      return 'I could not connect to the Wellness AI server. Please make sure the server is running.';
    }
  }

  Future<String> deleteConversation() async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/delete-conversation'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data['message'] ?? 'Conversation deleted.';
      }

      return 'Unable to delete the conversation.';
    } catch (e) {
      return 'Could not connect to the Wellness AI server.';
    }
  }
}