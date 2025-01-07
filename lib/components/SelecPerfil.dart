import 'package:flutter/material.dart';
import 'package:hbo_max/components/Home.dart';

class SelcecionarPerfil extends StatefulWidget {
  const SelcecionarPerfil({super.key});

  @override
  State<SelcecionarPerfil> createState() => _SelcecionarPerfilState();
}

class _SelcecionarPerfilState extends State<SelcecionarPerfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    const Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "¿Quién está viendo?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                50.0, 30.0, 50.0, 15.0),
                            child: Stack(
                              alignment: const Alignment(0.9, 0.9),
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HbomaxHome()),
                                        );
                                      },
                                      child: const CircleAvatar(
                                        backgroundImage:
                                            AssetImage('images/profile.png'),
                                        radius: 65.0,
                                        
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Edilso Yair'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                50.0, 30.0, 50.0, 15.0),
                            child: Stack(
                              alignment: const Alignment(0.9, 0.9),
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {},
                                      child: const CircleAvatar(
                                        backgroundImage:
                                            AssetImage('images/niños.png'),
                                        radius: 65.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Niños'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 15.0),
                        child: Stack(
                          alignment: const Alignment(0.9, 0.9),
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: const CircleAvatar(
                                    child: Icon(Icons.add),
                                    radius: 60.0,
                                    backgroundColor: Color.fromARGB(255, 37, 47, 95),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text('Nuevo perfil'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF2B3770),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Editar',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
