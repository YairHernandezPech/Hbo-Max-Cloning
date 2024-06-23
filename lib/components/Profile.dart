import 'package:flutter/material.dart';
import 'package:hbo_max/components/AuthApiFirebase.dart';
import 'package:hbo_max/components/InicioSecion1.dart';
import 'package:hbo_max/components/Home.dart';
import 'package:hbo_max/components/Search.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HbomaxHome()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search()),
      );
    }
  }

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF05072C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HbomaxHome()),
            );
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
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProfileIcon('Edilson Yair', 'images/profile.png'),
                _buildProfileIcon('Niños', 'images/niños.png'),
                _buildProfileIcon('', Icons.add),
              ],
            ),
            const SizedBox(height: 35),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF2B3770),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Edita los perfiles',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            _buildOptionTile(
              'Configuración de la aplicación',
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
              page: InicioSecion1(),
            ),
            _buildOptionTile(
              'Cuenta',
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
              page: InicioSecion1(),
            ),
            _buildOptionTile(
              'Suscripción',
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
              page: InicioSecion1(),
            ),
            _buildOptionTile(
              'Privacidad y Términos',
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
              page: InicioSecion1(),
            ),
            _buildOptionTile(
              'Ayuda',
              const Icon(Icons.ios_share, color: Colors.white),
              page: InicioSecion1(),
            ),
            _buildOptionTile(
              'Cerrar sesión',
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () async {
                await AuthService().signout(context: context);
              },
            ),
          ],
        ),
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

  Widget _buildProfileIcon(String name, dynamic iconOrImage) {
    Widget avatar;
    if (iconOrImage is IconData) {
      avatar = CircleAvatar(
        radius: 45,
        child: Icon(iconOrImage, size: 30),
        backgroundColor: Color.fromARGB(255, 37, 47, 95),
      );
    } else if (iconOrImage is String) {
      avatar = CircleAvatar(
        radius: 45,
        backgroundImage: AssetImage(iconOrImage),
      );
    } else {
      throw ArgumentError('iconOrImage must be either IconData or String');
    }

    return Column(
      children: [
        avatar,
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildOptionTile(String title, Widget icon,
      {Widget? page, Function()? onTap}) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: icon,
      onTap: onTap ??
          () {
            if (page != null) {
              _navigateToPage(page);
            }
          },
    );
  }
}
