import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoService {
  static const String apiUrl = 'https://your-api-url.com/todos';

  // Fetch todos from the API
  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body); // Decode JSON response to a List
      } else {
        throw Exception(
            'Failed to load todos. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching todos: $e');
    }
  }
}
