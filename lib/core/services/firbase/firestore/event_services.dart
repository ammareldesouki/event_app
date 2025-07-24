import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/models/event_model.dart';

class EventFireBaseFireStore {
  static CollectionReference<EventModel> _getCollectionReferance() {
    return FirebaseFirestore.instance
        .collection(EventModel.collectionName)
        .withConverter(
          fromFirestore:
              (snapshot, option) => EventModel.fromFirestore(snapshot.data()!),
          toFirestore: (value, _) => value.toFireStor(),
        );
  }

  static createNewEvent(EventModel eventModel) {
    var collectionreferance = _getCollectionReferance();
    var docomentsrecferance = collectionreferance.doc();
    docomentsrecferance.set(eventModel);
  }

  static getEventList() async {
    var collectionreferance = _getCollectionReferance();
    var dataColloction = await collectionreferance.get();
    return dataColloction.docs.map((e) {
      return e.data();
    }).toList();
  }
}
