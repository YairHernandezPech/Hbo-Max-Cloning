import 'package:flutter/material.dart';
import 'package:hbo_max/components/pdf.dart';
import 'package:share_plus/share_plus.dart';

void ModalBottom(BuildContext context, TickerProvider vsync) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Color.fromARGB(255, 23, 23, 23),
    transitionAnimationController: AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(seconds: 1),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'HBO MAX Las Película',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Solo por HBO MAX encuentras las mejores películas de todos los tiempos. ¡No te las pierdas!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Acción para agregar a la lista
              },
              child: const Row(
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Agregar película a Mi lista',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                await Share.share(
                    'Hey! Mira esta película en HBO Max: Duna https://www.hbomax.com/ve/es/movies/ttl0c0d0d0duna-2021');
              },
              child: const Row(
                children: [
                  Icon(Icons.share, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Comparte',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PdfView()),
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Más información',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
