import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oddjobs/models/tradesmen.dart';

class DatabaseService {
  //collection reference
  final String uid;
  final CollectionReference tradesmenCollection =
      FirebaseFirestore.instance.collection("tradesmen");
  DatabaseService({required this.uid});

  Future updateUserData(String Name, String About, String Location,
      List<String> Tags, String LatLong, String Phone) async {
    return await tradesmenCollection.doc(uid).set({
      'Name': Name,
      'About': About,
      'Location': Location,
      'Tags': Tags,
      'LatLong': LatLong,
      'Phone': Phone,
    });
  }

  List<TradesmenModel> _TradesmenListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TradesmenModel(
        name: doc.get('Name') ?? '',
        description: doc.get('About') ?? '0',
        location: doc.get('Location') ?? '0',
        tags: doc.get('Tags') ?? [],
        latlong: doc.get('LatLong') ?? '0',
        phone: doc.get('Phone') ?? 'O',
      );
    }).toList();
  }

  Stream<List<TradesmenModel>> get trades {
    return tradesmenCollection.snapshots().map(_TradesmenListFromSnapshot);
  }
}
