import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hbo_max/components/Favoritos.dart';
import 'package:hbo_max/components/ModalBottom.dart';
import 'package:hbo_max/components/Notificaciones.dart';
import 'package:hbo_max/components/Profile.dart';
import 'package:hbo_max/components/Search.dart';
import 'package:hbo_max/components/firebaseApi.dart';
import 'package:hbo_max/peliculas/BoosBaby.dart';
import 'package:hbo_max/peliculas/Duna.dart';
import 'package:hbo_max/peliculas/Gato.dart';
import 'package:hbo_max/peliculas/Kraken.dart';
import 'package:hbo_max/peliculas/Madmax.dart';
import 'package:hbo_max/peliculas/Mario.dart';
import 'package:hbo_max/peliculas/Pikachu.dart';
import 'package:hbo_max/peliculas/Potter.dart';
import 'package:hbo_max/peliculas/Shrek.dart';

class Content {
  final String imageUrl;
  final String routeName;

  Content(this.imageUrl, this.routeName);
}

class HbomaxHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HBO Max Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF05072C),
        primaryColor: const Color(0xFF05072C),
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/duna': (context) => Duna(),
        '/gato': (context) => Gato(),
        '/potter3': (context) => Potter(),
        '/madmax': (context) => Madmax(),
        '/mario': (context) => Mario(),
        '/pikachu': (context) => Pikachu(),
        '/shrek': (context) => Shrek(),
        '/kraken': (context) => Kraken(),
        '/the_boss_baby': (context) => BossBaby(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;

  final List<String> categories = [
    "Inicio",
    "Series",
    "Películas",
    "HBO",
    "Niños y Familia"
  ];

  final List<Content> soloParaTiContent = [
    Content('images/duna.jpeg', '/duna'),
    Content('images/gato.jpeg', '/gato'),
    Content('images/potter3.png', '/potter3'),
    Content('images/madmax.jpeg', '/madmax'),
    Content('images/mario.jpg', '/mario'),
    Content('images/pikachu.jpg', '/pikachu'),
    Content('images/shrek.jpeg', '/shrek'),
    Content('images/kraken.jpg', '/kraken'),
    Content('images/The_Boss_Baby.jpg', '/the_boss_baby'),
  ];

  final List<Content> soloParaTiContent2 = [
    Content('images/mario.jpg', '/mario'),
    Content('images/The_Boss_Baby.jpg', '/the_boss_baby'),
    Content('images/pikachu.jpg', '/pikachu'),
    Content('images/gato.jpeg', '/gato'),
    Content('images/shrek.jpeg', '/shrek'),
    Content('images/madmax.jpeg', '/madmax'),
    Content('images/kraken.jpg', '/kraken'),
    Content('images/potter3.png', '/potter3'),
    Content('images/duna.jpeg', '/duna'),
  ];

  final List<Content> soloParaTiContent3 = [
    Content('images/shrek.jpeg', '/shrek'),
    Content('images/kraken.jpg', '/kraken'),
    Content('images/madmax.jpeg', '/madmax'),
    Content('images/potter3.png', '/potter3'),
    Content('images/pikachu.jpg', '/pikachu'),
    Content('images/mario.jpg', '/mario'),
    Content('images/duna.jpeg', '/duna'),
    Content('images/gato.jpeg', '/gato'),
    Content('images/The_Boss_Baby.jpg', '/the_boss_baby'),
  ];

  final List<Map<String, String>> series = [
    {'image': 'images/duna.jpeg'},
    {'image': 'images/gato.jpeg'},
    {'image': 'images/madmax.jpeg'},
    {'image': 'images/pikachu.jpg'},
    {'image': 'images/mario.jpg'},
  ];

  final List<String> numberImages = [
    'images/num1.png',
    'images/num2.png',
    'images/num3.png',
    'images/num4.png',
    'images/num5.png',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    FirebaseApi().initNotifications(context);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isAppBarVisible) {
        setState(() {
          _isAppBarVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isAppBarVisible) {
        setState(() {
          _isAppBarVisible = true;
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HbomaxHome()),
      );
    }
    else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavoritesScreen()),
      );
    }
     else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _isAppBarVisible
          ? AppBar(
              title: Image.asset(
                'images/logo.png',
                height: 80,
                width: 80,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  // icon: const Icon(Icons.event_seat),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Notifications(),
                    ));
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    'images/profile.png',
                    height: 30,
                    width: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Profile(),
                    ));
                  },
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.srcOver,
                      ),
                      child: Image.asset(
                        'images/exorcista.jpeg',
                        width: double.infinity,
                        height: 700,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'EL',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 0),
                          const Center(
                            child: Text(
                              'EXORCISTA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 0),
                          const Center(
                            child: Text(
                              'CREYENTES',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                color: Colors.white,
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Text(
                                    'Nuevo',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                '16+',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                '1 temporada',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'El programa aborda acusaciones de acoso sexual, acoso y abuso contra Kevin Spacey, uno de los actores más poderosos y respetados del mundo.',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Solo para ti',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var content in soloParaTiContent)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, content.routeName);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 180,
                                  height: 280,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(1.0),
                                    image: DecorationImage(
                                      image: AssetImage(content.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      ModalBottom(context, this);
                                    },
                                    child: const Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var content in soloParaTiContent2)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, content.routeName);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 180,
                                  height: 280,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(1.0),
                                    image: DecorationImage(
                                      image: AssetImage(content.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      ModalBottom(context, this);
                                    },
                                    child: const Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  child: const Center(
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Image(
                              image: AssetImage(
                            'images/top.png',
                          )),
                        ))
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: series.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, String> series = entry.value;
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: Image.asset(
                                series['image']!,
                                height: 200,
                                width:
                                    140, // Ajusta el ancho de la imagen según tu diseño
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (index < numberImages.length)
                            Positioned(
                              left:
                                  -20, // Ajusta la posición izquierda para que se superponga
                              top: 150,
                              child: Image.asset(
                                numberImages[index],
                                height:
                                    50, // Ajusta el tamaño de la imagen del número
                                width: 50,
                                fit: BoxFit.contain,
                                // Añade opacidad si es necesario
                              ),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var content in soloParaTiContent3)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, content.routeName);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 180,
                                  height: 280,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(1.0),
                                    image: DecorationImage(
                                      image: AssetImage(content.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      ModalBottom(context, this);
                                    },
                                    child: const Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + kToolbarHeight,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _isAppBarVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                height: 50,
                color: Colors.transparent,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                            color: index == 0 ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark, size: 35),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 35),
            label: '',
          ),
        ],
      ),
    );
  }
}
