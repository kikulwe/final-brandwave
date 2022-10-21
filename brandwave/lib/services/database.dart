import "package:cloud_firestore/cloud_firestore.dart";
import "package:brandwave/models/Adverts.dart";
import "package:firebase_storage/firebase_storage.dart";
import 'dart:io';
import "package:brandwave/models/CustomUser.dart";


class DatabaseService {

//  collection reference
  final String ? uid;

  DatabaseService({this.uid});

  final CollectionReference advertCollection = FirebaseFirestore.instance.collection("adverts");
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");

  Future <dynamic> getImgUrl (String adName, File img) async {
    try {
      final firestoreRef = FirebaseStorage
          .instance
          .ref()
          .child("adverts/$adName.jpg");
      dynamic uploadTask = firestoreRef.putFile(img);
      final snapshot = await uploadTask!.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    }
    catch (e) {
      print("ERROR");
      print(e.toString());
    }

}

  Future<dynamic> addAdvert(String uid, String adName, String adDescription, String adLocation, File img) async {
    dynamic adImage = await getImgUrl(adName, img);

    // Call the user's CollectionReference to add a new user
    return advertCollection
      .add({
      "uid": uid,
      "adName": adName,
      "adDescription": adDescription,
      "adLocation": adLocation,
      "adImage": adImage
    });
  }


  Future<void> addUser(String uid, String username, String contact) {
    // Call the user's CollectionReference to add a new user
    return userCollection
        .add({
      "uid": uid,
      "username": username,
      "contact": contact
    });
  }

//  get advert streams
  Stream<List<Advert>> get adverts {
    return advertCollection.snapshots().map(_fromAdListFromSnap);
  }

  List<Advert> _fromAdListFromSnap(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Advert(
        uid: doc.get('uid'),
        adName: doc.get('adName'),
        description: doc.get('adDescription'),
        location: doc.get('adLocation'),
        imageUrl: doc.get('adImage'))
    ).toList();
  }

  Future getUser(String uid) async {
    return await userCollection.doc(uid).snapshots();
  }


}