import 'package:http/http.dart' as http;
import 'dart:convert';

Future fetchList() async {
  var url = 'https://thegrowingdeveloper.org/apiview?id=4';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var listResponse = json.decode(response.body);
    print(listResponse);
    return listResponse;
  }
  else{
    throw Exception('Unexpected error occured!');
  }
}
