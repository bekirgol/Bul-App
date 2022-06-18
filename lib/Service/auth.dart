import 'package:bul_app/Constand/network.dart';
import 'package:bul_app/Interfaces/auth_service.dart';
import 'package:bul_app/Models/login_response.dart';
import 'package:bul_app/Models/user.dart';
import 'package:http/http.dart' as http;

class Auth extends AuthService {
  @override
  Future<LoginResponse?> loginWithEmailAndPassword(
      String email, String password) async {
    String url = "${Constand.BASE_URL}/users/login";
    final response = await http.post(Uri.parse(url), body: {
      "mail": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      final result = loginResponseFromJson(response.body);
      return result;
    }
    throw response.body;
  }

  @override
  Future<User?> register(User user) async {
    String url = "${Constand.BASE_URL}/users/register";
    final response = await http.post(Uri.parse(url), body: {
      "name": user.name,
      "lastName": user.lastName,
      "mail": user.mail,
      "password": user.password,
    });

    if (response.statusCode == 200) {
      final result = userFromJson(response.body);
      return result;
    }
    throw response.body;
  }
}
