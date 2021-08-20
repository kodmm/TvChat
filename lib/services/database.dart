import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tvchat/helperfunctions/sharedpref_helper.dart';

class DatabaseMethods {
  final String broadcastingOffices = "broadcastingOffices";
  final String users = "users";
  final String chats = "chats";

  Future addUserInfoToDB(
      String userId, Map<String, String> userInfoMap
      ) async {
    return FirebaseFirestore.instance
        .collection(users)
        .doc(userId)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getBroadcastingOffices() async {
    return FirebaseFirestore.instance
        .collection(broadcastingOffices)
        .get();
  }

  Future<Stream<QuerySnapshot>> getChats(String broadcastingOffice) async {
    return FirebaseFirestore.instance
        .collection(broadcastingOffices)
        .doc(broadcastingOffice)
        .collection(chats)
        .snapshots();
  }



}