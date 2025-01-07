import 'package:flutter/material.dart';
import 'package:hbo_max/components/Home.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../Db/database.dart';

class BossBaby extends StatefulWidget {
  @override
  _BossBabyState createState() => _BossBabyState();
}

class _BossBabyState extends State<BossBaby> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  void _checkFavorite() async {
    bool favorite = await DatabaseHelper.instance.isFavorite('The Boss Baby');
    setState(() {
      isFavorite = favorite;
    });
  }

  void _toggleFavorite() async {
    if (isFavorite) {
      await DatabaseHelper.instance.removeFavorite('The Boss Baby');
    } else {
      await DatabaseHelper.instance.addFavorite(
        'The Boss Baby',
        'images/The_Boos_Baby2.jpeg',
        'Un bebé que usa traje formal y lleva un maletín se infiltra en la familia de un niño de 7 años para cumplir una inusual misión secreta.',
      );
    }
    _checkFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.srcOver,
            ),
            child: Image.asset(
              'images/The_Boos_Baby2.jpeg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HbomaxHome()),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_back_ios_outlined,
                            color: Colors.white),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'T H E  B O S S  B A B Y',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '7+   1h 38m   2017',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YoutubePlayerExample()),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.play_arrow, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Ver ahora',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.check : Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: _toggleFavorite,
                              ),
                              const Text(
                                'Mi lista',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(width: 32),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share,
                                    color: Colors.white),
                                onPressed: () async {
                                  await Share.share(
                                      'Hey! Mira esta película en HBO Max: The Boss Baby https://www.hbomax.com/ve/es/movies/ttl0c0d0d0bossbaby');
                                },
                              ),
                              const Text(
                                'Comparte',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Un bebé que usa traje formal y lleva un maletín se infiltra en la familia de un niño de 7 años para cumplir una inusual misión secreta.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Comedia   Infantil y Familiar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class YoutubePlayerExample extends StatefulWidget {
  @override
  _YoutubePlayerExampleState createState() => _YoutubePlayerExampleState();
}

class _YoutubePlayerExampleState extends State<YoutubePlayerExample> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'tquIfapGVqs', // ID del video de YouTube
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    // Forzar la orientación horizontal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();

    // Restaurar la orientación vertical cuando se sale de la pantalla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          print('Player is ready.');
        },
      ),
      builder: (context, player) {
        return Scaffold(
          body: Center(
            child: player,
          ),
        );
      },
    );
  }
}
