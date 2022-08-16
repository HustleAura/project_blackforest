import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final FirebaseAuth _firebaseAuth;
  late StreamSubscription<User?> _userAuthState;

  AuthenticationCubit(this._firebaseAuth)
      : super(
          AuthenticationState.signedOut,
        ) {
    _userAuthState = _firebaseAuth.authStateChanges().listen((authState) {
      if (authState == null) {
        emit(
          AuthenticationState.signedOut,
        );
      } else {
        emit(
          AuthenticationState.signedIn,
        );
      }
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
