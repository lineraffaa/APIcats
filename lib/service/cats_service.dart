import 'dart:convert';

import 'package:http/http.dart' as http;

final String api_Url = "BdgNLSRd8/Qsfo9pMU4dyw==jGduQpNWPmQTrbuS";

Future<List<dynamic>> fatosGatos(String? namecat) async {
  http.Response response;

  response = await http.get(
      // Uri.parse("http://api.api-ninjas.com/v1/cats?name=$namecat"),
      Uri.parse("http://api.api-ninjas.com/v1/cats?name=$namecat"),
      headers: {'X-Api-Key': api_Url});
//List<dynamic> jsonResponse = json.decode(response.body);
// return jsonResponse.cast<Map<String, dynamic>>();
  return json.decode(response.body);
}
