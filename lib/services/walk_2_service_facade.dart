import 'package:walk2_ui/constants/endpoints.dart';
import 'package:http/http.dart' as http;

class Walk2ServiceFacade {
  final String _baseUrl = Endpoints.walk2ServiceBaseUrl;

  Future<dynamic> getRecommendations({
    required Map<String, dynamic>? queryParams,
  }) async {
    final url = Uri.parse('$_baseUrl/recommendations').replace(
      queryParameters: queryParams?.map(
        (key, val) => MapEntry(key, val.toString()),
      ),
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("Error: ${response.body}");
    }
  }
}
