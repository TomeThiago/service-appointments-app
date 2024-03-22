import 'package:app/models/logged_user.dart';
import 'package:app/repositories/category_repository.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthServiceProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  LoggedUser? loggedUser;

  Future<User?> signUp(String email, String password) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    _isAuthenticated = true;

    notifyListeners();

    return credential.user;
  }

  Future<User?> signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    final user = credential.user;

    if(user != null && user.email != null) {
      loggedUser = await UserRepository().getUserByEmail(user.email!);

      if(loggedUser != null && loggedUser?.typeProfile == 'worker' && loggedUser?.categoryId != null) {
          var category = await CategoryRepository().getCategoryById(loggedUser?.categoryId ?? '');

          loggedUser?.categoryTitle = category?.title ?? 'Não Informado';
      }
    }

    return credential.user;
  }

  signOut() async {
    await _auth.signOut();

    _isAuthenticated = false;

    notifyListeners();
  }
}
