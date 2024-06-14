import 'package:flutter/material.dart';
import 'package:hbo_max/components/ModalBottom.dart';

class Notifications extends StatefulWidget {
  final String? title;
  final String? body;

  Notifications({this.title, this.body});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'image': 'images/mario2.jpeg',
        'title': widget.title ?? 'Super Mario Bros.La Pelicula',
        'body': widget.body ?? 'Todos',
        'year': '2023'
      },
      {
        'image': 'images/duna2.jpeg',
        'title': 'Duna',
        'ageRating': '13+',
        'year': '2021'
      },
      {
        'image': 'images/pikachu2.jpeg',
        'title': 'Pikachu Dectevive',
        'ageRating': '10+',
        'season': '2019'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF05072C),
        title: const Center(
          child: Text(
            'Novedades',
            style:TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF05072C),
              Color(0xFF2B3770),
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    item['image'],
                    width: 160,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              item.containsKey('body') ? item['body'] : item['ageRating'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item['year'] ?? item['season'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      ModalBottom(context, this);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}