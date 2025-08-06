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

  static Stream<QuerySnapshot<EventModel>> getStreemeventList() {
    var collectionReference = _getCollectionReferance();

    return collectionReference.snapshots();
  }

  static Stream<QuerySnapshot<EventModel>> getStreemeventFavouritList() {
    var collectionReference = _getCollectionReferance().where(
        "isFavourite", isEqualTo: true
    );


    return collectionReference.snapshots();
  }
  static Stream<QuerySnapshot<EventModel>> getStreemeventSearchFavouritList(String keyword) {
    String query = keyword.toLowerCase();

    var collectionReference = _getCollectionReferance()
        .where("isFavourite", isEqualTo: true)
        .where('title', isEqualTo: keyword);

    return collectionReference.snapshots();
  }


  static Stream<QuerySnapshot<EventModel>> getStreemeventtListByCategory(
      {required String CategoryName}) {
    var collectionReference = _getCollectionReferance()
        .where("categoryName", isEqualTo: CategoryName);

    return collectionReference.snapshots();
  }





}
