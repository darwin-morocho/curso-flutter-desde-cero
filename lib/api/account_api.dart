import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountAPI {
  Future<bool> login(String email, String password) async {
    try {
      final http.Response response = await http.post(
          "https://reqres.in/api/login",
          body: jsonEncode({"email": email, "password": password, "age": 25}),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final dynamic parsed = jsonDecode(response.body);
        print("login OK ${parsed["token"]}");
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> getUsers(int page) async {
    try {
      final http.Response response =
          await http.get("https://reqres.in/api/users?page=$page&delay=3");

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        print("getUsers ok");
        print(parsed['data'].runtimeType);
        return parsed['data'];
      }
      print("error ${response.statusCode} ");

      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
