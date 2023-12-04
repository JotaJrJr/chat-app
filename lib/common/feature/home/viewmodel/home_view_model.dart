import 'package:chat_app/common/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeViewModel {
  final AuthService authService;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  HomeViewModel({required this.authService});

  Future<void> signOut() async {
    return await authService.signOut();
  }

  stream() {
    return _firestore.collection('users').snapshots();
  }
}
