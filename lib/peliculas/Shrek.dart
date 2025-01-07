import 'package:flutter/material.dart';
import 'package:hbo_max/components/Home.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../Db/database.dart';

class Shrek extends StatefulWidget {
  @override
  _ShrekState createState() => _ShrekState();
}

class _ShrekState extends State<Shrek> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  void _checkFavorite() async {
    bool favorite = await DatabaseHelper.instance.isFavorite('Shrek');
    setState(() {
      isFavorite = favorite;
    });
  }

  void _toggleFavorite() async {
    if (isFavorite) {
      await DatabaseHelper.instance.removeFavorite('Shrek');
    } else {
      await DatabaseHelper.instance.addFavorite(
        'Shrek',
        'images/shrek2.jpeg',
        'Los padres de Fiona, los reyes de Muy Muy Lejano, invitan a cenar a la princesa y a Shrek sin imaginarse que los recién casados son un par de ogros.',
      );
    }
    _checkFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/shrek2.jpeg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
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
                        'S H R E K',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '7+   1h 33m   2004',
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
                                      'Hey! Mira esta película en HBO Max: Shrek https://www.hbomax.com/ve/es/movies/ttl0c0d0d0shrek');
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
                        'Los padres de Fiona, los reyes de Muy Muy Lejano, invitan a cenar a la princesa y a Shrek sin imaginarse que los recién casados son un par de ogros.',
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
      initialVideoId: 'MuUwZD2cb4A', // ID del video de YouTube
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
