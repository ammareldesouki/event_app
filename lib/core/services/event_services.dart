import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/models/event_model.dart';

class EventFireBaseFireStore {
  // Get collection reference with converter
  static CollectionReference<EventModel> _getCollectionReferance() {
    return FirebaseFirestore.instance
        .collection(EventModel.collectionName)
        .withConverter<EventModel>(
          fromFirestore:
              (snapshot, _) =>
                  EventModel.fromFirestore(snapshot.data()!, id: snapshot.id),
          toFirestore: (event, _) => event.toFireStor(),
        );
  }

  // Create new event
  static Future<void> createNewEvent(EventModel eventModel) async {
    var collectionReference = _getCollectionReferance();
    var documentReference = collectionReference.doc();
    await documentReference.set(eventModel);
  }

  // Get all events (with IDs)
  static Future<List<EventModel>> getEventList() async {
    var collectionReference = _getCollectionReferance();
    var querySnapshot = await collectionReference.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // Delete event by ID
  static Future<void> deleteEvent(String? id) async {
    if (id == null) return;
    var collectionReference = _getCollectionReferance();
    var documentReference = collectionReference.doc(id);
    await documentReference.delete();
  }

  // Update existing event
  static Future<void> updateEvent(EventModel eventModel) async {
    if (eventModel.id == null) return;
    var collectionReference = _getCollectionReferance();
    var documentReference = collectionReference.doc(eventModel.id);
    await documentReference.set(eventModel);
  }
}
