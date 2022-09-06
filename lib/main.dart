import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_blackforest/logic/firestore_service.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => FireStoreService(
            firebaseFirestoreInstance: FirebaseFirestore.instance,
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationCubit(
              FirebaseAuth.instance,
            ),
          )
        ],
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
      ),
    );
  }
}
