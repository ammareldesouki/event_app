import 'package:event_app/core/services/firbase/firestore/event_services.dart';

class AppDataService {
  static Map<String, dynamic>? currentUserData;
  static List<Map<String, dynamic>> userLogs = [];
  static List events = [];

  _getEventList() async {
    events = await EventFireBaseFireStore.getEventList();
  }
}
