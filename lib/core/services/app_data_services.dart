import 'package:event_app/core/services/event_services.dart';

class AppDataService {
  static Map<String, dynamic>? currentUserData;
  static List<Map<String, dynamic>> userLogs = [];
  static List events = [];

  static getEventList() async {
    events = await EventFireBaseFireStore.getEventList();
  }
}
