import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tvchat/helperfunctions/sharedpref_helper.dart';

class DatabaseMethods {
  final String broadcastingOffices = "broadcastingOffices";
  final String users = "users";

  Future addUserInfoToDB(
      String userId, Map<String, String> userInfoMap
      ) async {
    return FirebaseFirestore.instance
        .collection(users)
        .doc(userId)
        .set(userInfoMap);
  }




}