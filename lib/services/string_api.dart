import 'package:http/http.dart' as http;

Future fetchString() async {
  var url = 'https://thegrowingdeveloper.org/apiview?id=1';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var stringResponse = response.body;
    print(stringResponse);
    return stringResponse;
  }
}
