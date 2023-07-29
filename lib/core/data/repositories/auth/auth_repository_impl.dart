import 'package:app/core/data/repositories/auth/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> checkAuthentication() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user != null;
    } catch (e) {
      // Handle any exceptions that occur during the check
      // You can show an error message here if required
      return false;
    }
  }

  @override
  Future<String?> getUserImageURL(String uid) async {
    try {
      // Fetch the user information from the database and get the image URL
      // For example, if you're using Firestore:
      final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
      final userSnapshot = await userRef.get();
      final imageUrl = userSnapshot.data()?['image_url'];

      return imageUrl ?? '';
    } catch (e) {
      // Handle any exceptions that occur during image URL retrieval
      // You can show an error message here if required
      return '';
    }
  }

  @override
  Future<String?> getUserUUID() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user?.uid;
    } catch (e) {
      // Handle any exceptions that occur during UUID retrieval
      // You can show an error message here if required
      return null;
    }
  }

  @override
  Future<String?> getUserEmail() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user?.email;
    } catch (e) {
      // Handle any exceptions that occur during email retrieval
      // You can show an error message here if required
      return null;
    }
  }

  @override
  Future<String?> getUserName(String uid) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
      final userSnapshot = await userRef.get();
      final userName = userSnapshot.data()?['user_name'];
      return userName;
    } catch (e) {
      // Handle any exceptions that occur during name retrieval
      // You can show an error message here if required
      return null;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Create a new document in the users collection with the uid
      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid);

      // Save the user information to the database
      await userRef.set({
        'user_name': username,
        'image_url': '',
      });

      return userCredential.user != null;
    } catch (e) {
      // Handle any exceptions that occur during registration
      // You can show an error message here if required
      return false;
    }
  }
}
