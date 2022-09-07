import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/authentication_cubit/authentication_cubit.dart';
import 'auth_page.dart';
import 'home_page.dart';

class LandPage extends StatelessWidget {
  const LandPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state == AuthenticationState.signedIn) {
            return const HomePage();
          } else {
            return const AuthPage(true);
          }
        },
      ),
    );
  }
}
