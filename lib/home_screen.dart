import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  HomeScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, $username'),
        backgroundColor: Color(0xFF376C5C),  // Verde que mencionaste
      ),
      body: Center(
        child: Text(
          '¡Hola $username! Has iniciado sesión con éxito.',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF376C5C),  // Verde que mencionaste
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),  // Icono para Reportes
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),  // Icono para Tarjetas
            label: 'Tarjetas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),  // Icono para Inicio
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),  // Icono para Perfil
            label: 'Perfil',
          ),
        ],
        selectedItemColor: Color(0xFF376C5C), // Color de los íconos seleccionados
        unselectedItemColor: Color(0xFF376C5C),  // Color de los íconos no seleccionados
      ),
    );
  }
}

