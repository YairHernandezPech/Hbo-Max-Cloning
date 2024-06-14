import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hbo_max/components/SelecPerfil.dart';

class InicioSesion extends StatefulWidget {
  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
      child: ListView(children: [
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
                        "Iniciar Sesión",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Center(
                  child: Text(
                    "Igresa la direccion de correo electronico y la contraseña de tu cuenta",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Center(
                  child: Text(
                    "de Max o de HBO MAX",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Correo electronico',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Contraseña',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          height: 48,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.white,
                              ),
                              suffixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                const TextButton(
                  onPressed: null,
                  child: Text(
                    '¿Olvidaste la contraseña?',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Righteous',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelcecionarPerfil()),
                    );
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)))),
                    minimumSize: MaterialStatePropertyAll(Size(320, 37)),
                  ),
                  child: const Text(
                    "Iniciar sesión",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontFamily: 'AkayaTelivigala',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 320,
                  child: ElevatedButton(
                    onPressed: () {
                      _SingINWithGoogle();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(
                          0xFFFFA726)), // Color similar al de la imagen
                      shape: MaterialStateProperty.all(const StadiumBorder()),
                      minimumSize: MaterialStateProperty.all(const Size(0, 45)),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Sign in with Google",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const TextButton(
                  onPressed: null,
                  child: Text(
                    '¿Necesitas ayuda para iniciar sesión?',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Righteous',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    ));
  }

  _SingINWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelcecionarPerfil()),
        );
      }
    } catch (error) {
      print(error);
    }
  }
}
