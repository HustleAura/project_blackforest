import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_blackforest/logic/authentication_cubit/authentication_cubit.dart';

import '../../constants/colors.dart';
import '../../constants/lotties.dart';
import '../widgets/input_field.dart';
import '../widgets/password_field.dart';
import '../widgets/rounded_button.dart';

class AuthPage extends StatefulWidget {
  // this tells whether to render the login or signup page since both are in one widget
  final bool _isLogin;
  const AuthPage(this._isLogin);

  @override
  State<AuthPage> createState() => _AuthPageState(_isLogin);
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin;
  _AuthPageState(this._isLogin);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    TextEditingController _emailController = TextEditingController(),
        _passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, _height * 0.1, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // welcome caption
            Padding(
              padding:
                  EdgeInsets.fromLTRB(_height * 0.05, 0, _height * 0.05, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Talk with QR',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          color: primaryColor,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  // lottie animation from assets
                  SizedBox(
                    child: Lottie.asset(
                      (_isLogin) ? loginLottie : signUpLottie,
                    ),
                    height: _height * 0.5,
                    width: _width,
                  ),

                  // credential input fields
                  InputField('email', Icons.add, _emailController),
                  PasswordField(
                    _passwordController,
                  ),

                  // Button for login / signup
                  RoundedButton(
                    (_isLogin) ? 'LOGIN' : 'SIGNUP',
                    () {
                      (_isLogin)
                          ? context.read<AuthenticationCubit>().signIn(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              )
                          : context.read<AuthenticationCubit>().signUp(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                    },
                  ),

                  // option to alter login and signup. This inverts _islogin property
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (_isLogin)
                            ? 'Don\'t have an account?'
                            : 'Already have an account?',
                        style: const TextStyle(
                          color: primaryColor,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          (_isLogin) ? ' Sign Up ' : ' Log in ',
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
