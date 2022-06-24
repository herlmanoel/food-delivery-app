
import 'package:ecommercefood/src/shared/auth/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  Future<void> googlesignin(BuildContext context) async {
    final authController = AuthController();
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      print(response);
      authController.setUser(context, response);
    } catch (error) {
      print(error);
      authController.setUser(context, null);
    }
  }
}
