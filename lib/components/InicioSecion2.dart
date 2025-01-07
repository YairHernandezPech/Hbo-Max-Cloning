import 'package:flutter/material.dart';
import 'package:hbo_max/components/InicioSecion3.dart';
import 'package:hbo_max/components/Home.dart';

class InicioSecion2 extends StatelessWidget {
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
      ), // Fondo similar al de la imagen
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding:  EdgeInsets.only(
                    top: 40.0), // Ajusta el valor según necesites
                child: Text(
                  'Comenzar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                title: 'Iniciar sesión',
                description:
                    'Ingresa el correo electrónico y la contraseña de tu cuenta de Max o de HBO Max.',
                buttonText: 'Iniciar sesión',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InicioSesion()),
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Conecta a tu proveedor',
                description:
                    '¿Tienes Max o HBO Max a través de un proveedor de Internet, telefonía móvil o televisión?',
                buttonText: 'Conectar',
                onPressed: () {
                  // Acción para conectar a proveedor
                },
              ),
              const Spacer(), // Empuja el contenido hacia arriba
              TextButton(
                onPressed: () {
                  // Acción para abrir privacidad y legales
                },
                child: const Text(
                  'Privacidad y Legales',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101D63),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            textAlign: TextAlign.center, // Centra el texto de la descripción
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B3770), // Fondo del botón
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
