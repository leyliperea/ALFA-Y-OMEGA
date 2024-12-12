import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  HomeScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, $username'),
        backgroundColor: Color(#ffccee), // Nuevo color verde
      ),
      body: Center(
        child: Text(
          '¡Hola $username! Has iniciado sesión con éxito.',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(#ffccee), // Nuevo color verde
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), // Ícono de carrito
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category), // Ícono de categoría
            label: 'Categoría',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ícono de inicio
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), // Ícono de perfil
            label: 'Perfil',
          ),
        ],
        selectedItemColor: Colors.white, // Color para el ítem seleccionado
        unselectedItemColor: Colors.white54, // Color para los ítems no seleccionados
      ),
    );
  }
}
