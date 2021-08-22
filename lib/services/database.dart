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
        .get()
        .then((documentSnapshot){
          Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
          if (!data['users'].contains(myUsername)) {
            FirebaseFirestore.instance
                .collection(broadcastingOffices)
                .doc(broadcastingOffice)
                .update({
              "users": FieldValue.arrayUnion([myUsername])
            });
          }
        });


  }

  addMessage(String broadcastingOffice, messageId, Map<String, dynamic> messageInfoMap) {
    FirebaseFirestore.instance
        .collection(broadcastingOffices)
        .doc(broadcastingOffice)
        .collection(chats)
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(String broadcastingOffice, Map<String, dynamic> broadCastingOfficeMap) {
    FirebaseFirestore.instance
        .collection(broadcastingOffices)
        .doc(broadcastingOffice)
        .update(broadCastingOfficeMap);
  }
}