import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/modules/authentication/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save user data to Firestore
  static Future<void> saveUserData(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
      print('✅ User data saved successfully for UID: ${user.uid}');
    } catch (e) {
      print('❌ Error saving user data: $e');
      throw e;
    }
  }

  // Get user data from Firestore
  static Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        final userData = UserModel.fromMap(doc.data()!);
        print('✅ User data retrieved successfully for UID: $uid');
        return userData;
      } else {
        print('⚠️ No user data found for UID: $uid');
        return null;
      }
    } catch (e) {
      print('❌ Error getting user data: $e');
      return null;
    }
  }

  // Get current user data
  static Future<UserModel?> getCurrentUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      print('🔍 Getting data for current user: ${user.uid}');
      return await getUserData(user.uid);
    } else {
      print('⚠️ No current user found');
      return null;
    }
  }

  // Update user data
  static Future<void> updateUserData(
    String uid,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
      print('✅ User data updated successfully for UID: $uid');
    } catch (e) {
      print('❌ Error updating user data: $e');
      throw e;
    }
  }

  // Create user from Firebase User and save to Firestore
  static Future<UserModel> createUserFromFirebaseUser(
    User firebaseUser, {
    String? name,
  }) async {
    print('🔄 Creating user data for Firebase user: ${firebaseUser.uid}');

    final userModel = UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: name ?? firebaseUser.displayName ?? 'User',
      photoUrl: firebaseUser.photoURL,
      role: 'user', // default role
    );

    print('📝 User model created: ${userModel.toMap()}');

    // Save to Firestore
    await saveUserData(userModel);
    return userModel;
  }

  // Check if user exists in Firestore
  static Future<bool> userExists(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      final exists = doc.exists;
      print('🔍 User exists check for UID $uid: $exists');
      return exists;
    } catch (e) {
      print('❌ Error checking if user exists: $e');
      return false;
    }
  }

  // Delete user data (for cleanup)
  static Future<void> deleteUserData(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
      print('✅ User data deleted successfully for UID: $uid');
    } catch (e) {
      print('❌ Error deleting user data: $e');
      throw e;
    }
  }
}
