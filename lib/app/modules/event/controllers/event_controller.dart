import 'package:get/get.dart';

class EventModel {
  final String title;
  final String date;
  final String image;

  EventModel({required this.title, required this.date, required this.image});
}

class EventController extends GetxController {
  var userName = 'Ryan'.obs;

  var events = <EventModel>[
    EventModel(
      title: 'PARTY AKHIR PEKAN',
      date: 'SABTU, 23 Desember 2023',
      image: 'assets/images/PartyAkhir.png',
    ),
    EventModel(
      title: 'HANGGAR',
      date: 'JUM\'AT, 1 Maret 2023',
      image: 'assets/images/Hanggar.png',
    ),
    EventModel(
      title: 'REGGAE NIGHT',
      date: 'SABTU, 30 September 2023',
      image: 'assets/images/Reggae.png',
    ),
  ].obs;
}
