// event_controller.dart
import 'package:get/get.dart';

class EventModel {
  final String title;
  final String date;
  final String image;
  final String category;

  EventModel({
    required this.title,
    required this.date,
    required this.image,
    required this.category,
  });
}

class EventController extends GetxController {
  var username = 'Ryan'.obs;
  var selectedCategory = ''.obs;
  var searchQuery = ''.obs;

  final events = <EventModel>[
    EventModel(
        title: 'PARTY AKHIR PEKAN',
        date: 'SABTU, 23 Desember 2023',
        image: 'assets/images/PartyAkhir.png',
        category: 'Musik'),
    EventModel(
        title: 'HANGGAR',
        date: 'JUM\'AT, 1 Maret 2023',
        image: 'assets/images/Hanggar.png',
        category: 'Pameran'),
    EventModel(
        title: 'REGGAE NIGHT',
        date: 'SABTU, 30 September 2023',
        image: 'assets/images/Reggae.png',
        category: 'Musik'),
  ].obs;

  List<EventModel> get filteredEvents {
    final query = searchQuery.value.toLowerCase();
    final category = selectedCategory.value;

    return events.where((e) {
      final matchCategory = category.isEmpty || e.category == category;
      final matchQuery = query.isEmpty || e.title.toLowerCase().contains(query);
      return matchCategory && matchQuery;
    }).toList();
  }
}
