import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tvchat/helperfunctions/sharedpref_helper.dart';
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

  Stream<QuerySnapshot> getChats(String broadcastingOffice) {
    return FirebaseFirestore.instance
        .collection(broadcastingOffices)
        .doc(broadcastingOffice)
        .collection(chats)
        .snapshots();
  }

  Future<void>joinChats(String broadcastingOffice) async {
    String myUsername = SharedPreferenceHelper().getUserName().toString();
    FirebaseFirestore.instance
        .collection(broadcastingOffices)
        .doc(broadcastingOffice)
        .collection(chats)
        .where("users", arrayContains: myUsername.toString())
        .get()
        .then((querySnapshot){
          if (querySnapshot.docs.isEmpty) {
            FirebaseFirestore.instance
                .collection(broadcastingOffice)
                .doc(broadcastingOffice)
                .collection(chats)
                .doc("chat")
                .update({
              "users": FieldValue.arrayUnion([myUsername])
            });
          }
        });


  }
}