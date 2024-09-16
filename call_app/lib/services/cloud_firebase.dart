import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription? _userSubscribe;
  List<Map<String, dynamic>> userList = [];

  /* veriEklemeAdd(String tc, String telefonNo) async {
    Map<String, dynamic> _eklenecekUser = <String, dynamic>{};
    _eklenecekUser['tc'] = tc;
    _eklenecekUser['telefoNo'] = telefonNo;
    await firestore.collection('users2').add(_eklenecekUser);
  }*/

  /* Stream<List<Map<String, dynamic>>> veriOkuRealTime() {
    var userStream = firestore.collection('users').snapshots();

    return userStream.map((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> userList = [];
      querySnapshot.docChanges.forEach((element) {
        // Veriyi alın ve userList'e ekleyin
        userList.add(element.doc.data() as Map<String, dynamic>);
      });
      return userList;
    });
  }*/

  Future<void> deleteUser(String mobileNumber) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('mobilenumber', isEqualTo: mobileNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  Future<void> updateUserDirectCallStatus(String mobileNumber) async {
    QuerySnapshot querySnapshot =
        await firestore.collection('users').where('mobilenumber', isEqualTo: mobileNumber).get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      // Belirli bir belgenin içeriğini alın
      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;

      // 'direkara' alanını güncelleyin
      userData['direkara'] = false;

      // Güncellenmiş veriyi Firestore'a geri gönderin
      await firestore.collection('users').doc(documentSnapshot.id).update(userData);
    }
  }

  Stream<List<Map<String, dynamic>>> veriOkuRealTime() {
    var userStream = firestore.collection('users').snapshots();
    // verilerimizi burada dinliyoruz.
    return userStream.map((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> userList = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        // Sadece direkara true olan kullanıcıları listeye ekle
        userList.add(userData);
      });
      return userList;
    });
  }

  /* Future<List<Map<String, dynamic>>> veriOkuOneTime() async {
    var _usersDocument = await firestore.collection('users').get();
    List<Map<String, dynamic>> userList = [];

    for (var musteri in _usersDocument.docs) {
      Map<String, dynamic> userMap = musteri.data();
      userList.add(userMap);
    }

    print('$userList');

    return userList;
  }*/

  /*Future<void> veriEklemeAddd(Map<String, dynamic> userList, String _callStatus, int index) async {
    Map<String, dynamic> user = <String, dynamic>{};
    userList[index]['callstatus'] = '$_callStatus';

    await firestore.collection('users').add(userList);
  }*/

  Future<void> updateUserCallStatus(String phoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('mobilenumber', isEqualTo: phoneNumber)
          .get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        // Belirli bir belgenin içeriğini alın
        Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;

        // 'callstatus' alanını güncelleyin
        userData['callstatus'] = 'Arama Bitti';

        // Güncellenmiş veriyi Firestore'a geri gönderin
        await firestore.collection('users').doc(documentSnapshot.id).update(userData);
      }
    } catch (e) {
      print('Firestore güncelleme hatası: $e');
    }
  }
}
