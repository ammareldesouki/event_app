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

  static Stream<QuerySnapshot<EventModel>> getStreemeventFavouritList( String userid) {
    var collectionReference = _getCollectionReferance().where(
        "isFavourite", isEqualTo: true
    ).where("userId",isEqualTo: userid);


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

  // Get events by user ID
  static Stream<QuerySnapshot<EventModel>> getStreemeventListByUserId(String userId) {
    var collectionReference = _getCollectionReferance()
        .where("userId", isEqualTo: userId);

    return collectionReference.snapshots();
  }

  // Get events by user ID and category
  static Stream<QuerySnapshot<EventModel>> getStreemeventListByUserIdAndCategory(
      {required String userId, required String categoryName}) {
    var collectionReference = _getCollectionReferance()
        .where("userId", isEqualTo: userId)
        .where("categoryName", isEqualTo: categoryName);

    return collectionReference.snapshots();
  }


}
