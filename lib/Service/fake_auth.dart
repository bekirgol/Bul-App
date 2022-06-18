import 'package:bul_app/Interfaces/auth_service.dart';
import 'package:bul_app/Models/login_response.dart';
import 'package:bul_app/Models/user.dart';

class FakeAuth implements AuthService {
  @override
  Future<LoginResponse?> loginWithEmailAndPassword(
      String email, String password) async {
    // LoginResponse _loginResponse = LoginResponse(
    //     status: "succes",
    //     token: "12345",
    //     user: User(
    //       id: "1",
    //       name: "Bekir",
    //       lastName: "Göl",
    //       mail: "bekirgol20@gmail.com",
    //       password: "112233",
    //     ));
    // return _loginResponse;
  }

  @override
  Future<User?> register(User user) async {
    User _user = User(
      id: "1",
      name: "Bekir",
      lastName: "Göl",
      mail: "bekirgol20@gmail.com",
      password: "112233",
    );
    return _user;
  }
}
