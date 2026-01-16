import 'package:ecommerce_app/LoginPage/Model/user_model.dart';


class AuthService {
  static final List<UserModel> users = [
    UserModel(
      id: 1,
      email: 'amangupta@gmail.com',
      password: 'Aman@1234',
    ),
    UserModel(
      id: 2,
      email: 'test@gmail.com',
      password: 'Test@123',
    ),
  ];

  static bool login(String email, String password) {
    return users.any(
          (user) =>
      user.email == email.trim() &&
          user.password == password.trim(),
    );
  }
}
