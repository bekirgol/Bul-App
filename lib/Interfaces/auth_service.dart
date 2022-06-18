import 'package:bul_app/Models/login_response.dart';
import 'package:bul_app/Models/user.dart';

abstract class AuthService {
  Future<LoginResponse?> loginWithEmailAndPassword(
      String email, String password);
  Future<User?> register(User user);
}
