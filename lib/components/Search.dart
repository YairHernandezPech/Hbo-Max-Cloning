import 'package:flutter/material.dart';
import 'package:hbo_max/components/Home.dart';
import 'package:hbo_max/components/ModalBottom.dart';
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
  final String title;

  Content(this.imageUrl, this.routeName, this.title);
}

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

final List<Content> soloParaTiContent = [
  Content('images/duna.jpeg', '/duna', 'Duna'),
  Content('images/gato.jpeg', '/gato', 'Gato con Botas'),
  Content('images/potter3.png', '/potter3', 'Harry Potter 3'),
  Content('images/madmax.jpeg', '/madmax', 'Mad Max'),
  Content('images/mario.jpg', '/mario', 'Mario'),
  Content('images/pikachu.jpg', '/pikachu', 'Pikachu'),
  Content('images/shrek.jpeg', '/shrek', 'Shrek'),
  Content('images/kraken.jpg', '/kraken', 'Kraken'),
  Content('images/The_Boss_Baby.jpg', '/the_boss_baby', 'The Boss Baby'),
];

class _SearchState extends State<Search> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  List<Content> _filteredContent = soloParaTiContent;

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
  }

  void _filterContent(String query) {
    setState(() {
      _filteredContent = soloParaTiContent
          .where((content) => content.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _filterContent(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white70),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          backgroundColor: Color(0xFF05072C),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF05072C),
                    Color(0xFF05072C)
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var content in _filteredContent)
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
                  
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: BottomNavigationBar(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
