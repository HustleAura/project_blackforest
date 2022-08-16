import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/auth_page.dart';
import 'presentation/screens/home_page.dart';
import 'logic/authentication_cubit/authentication_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    firebaseAuth: FirebaseAuth.instance,
  ));
}

class MyApp extends StatelessWidget {
  FirebaseAuth firebaseAuth;
  MyApp({Key? key, required this.firebaseAuth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(firebaseAuth),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              if (state == AuthenticationState.signedIn) {
                return HomePage();
              } else {
                return AuthPage(true);
              }
            },
          ),
        ),
      ),
    );
  }
}
