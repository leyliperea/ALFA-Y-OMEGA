import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nombreController = TextEditingController();
  final _primerApellidoController = TextEditingController();
  final _segundoApellidoController = TextEditingController();

  bool _isLogin = true; // Alternar entre login y registro
  bool _isLoading = false; // Estado de carga

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    
    String email = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    try {
      final dbHelper = DatabaseHelper();
      final user = await dbHelper.getUserByEmail(email);
      if (user != null && user['password'] == password) {
        // Login exitoso
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(username: email)),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Credenciales incorrectas')),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inesperado: $error')),
      );
    }
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    String email = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String nombre = _nombreController.text.trim();
    String primerApellido = _primerApellidoController.text.trim();
    String segundoApellido = _segundoApellidoController.text.trim();

    if (email.isEmpty || password.isEmpty || nombre.isEmpty || primerApellido.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos obligatorios')),
      );
      return;
    }

    try {
      final dbHelper = DatabaseHelper();
      final userExists = await dbHelper.getUserByEmail(email);
      
      if (userExists != null) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('El correo electrónico ya está registrado')),
        );
        return;
      }

      // Insertar nuevo usuario en la base de datos local
      await dbHelper.insertUser({
        'email': email,
        'password': password,
        'nombre': nombre,
        'primer_apellido': primerApellido,
        'segundo_apellido': segundoApellido,
      });

      setState(() {
        _isLoading = false;
        _isLogin = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso, ahora puedes iniciar sesión')),
      );
      
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inesperado: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF376C5C),
      appBar: AppBar(
        backgroundColor: Color(0xFF376C5C),
        title: Text(_isLogin ? 'Iniciar Sesión' : 'Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/logo.png', height: 100),
              SizedBox(height: 30),
              Text(
                _isLogin ? 'Iniciar Sesión' : 'Crear Cuenta',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                  prefixIcon: Icon(Icons.person, color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              if (!_isLogin) ...[
                TextField(controller:_nombreController, decoration:
                   InputDecoration(labelText:'Nombre', filled:true, fillColor:
                   Colors.white, border:
                   OutlineInputBorder(borderRadius:
                   BorderRadius.circular(12.0), borderSide:
                   BorderSide(color:
                   Colors.grey)), enabledBorder:
                   OutlineInputBorder(borderRadius:
                   BorderRadius.circular(12.0), borderSide:
                   BorderSide(color:
                   Colors.grey)), focusedBorder:
                   OutlineInputBorder(borderRadius:
                   BorderRadius.circular(12.0), borderSide:
                   BorderSide(color:
                   Color(0xFF376C5C))),),),
                SizedBox(height:
                20,),
                TextField(controller:_primerApellidoController, decoration:
                   InputDecoration(labelText:'Primer Apellido', filled:true, fillColor:
                   Colors.white, border:
                   OutlineInputBorder(borderRadius:
                   BorderRadius.circular(12.0), borderSide:
                   BorderSide(color:
                   Colors.grey)), enabledBorder:
                   OutlineInputBorder(borderRadius:
                   BorderRadius.circular(12.0), borderSide:
                   BorderSide(color:
                   Colors.grey)), focusedBorder:
                   OutlineInputBorder(borderRadius:
                   BorderRadius.circular(12.0), borderSide:
                   BorderSide(color:
                   Color(0xFF376C5C))),),),
                SizedBox(height:
                20,),
                TextField(controller:_segundoApellidoController, decoration:
                   InputDecoration(labelText:'Segundo Apellido (opcional)', filled:true, fillColor:
                   Colors.white, border:
                   OutlineInputBorder(borderRadius:
                   BorderRadius.circular(12.0), borderSide:
                   BorderSide(color:
                   Colors.grey)), enabledBorder:
                   OutlineInputBorder(borderRadius:
                   BorderRadius.circular(12.0), borderSide:
                   BorderSide(color:
                   Colors.grey)), focusedBorder:
                   OutlineInputBorder(borderRadius:
                   BorderRadius.circular(12.0), borderSide:
                   BorderSide(color:
                   Color(0xFF376C5C))),),),
              ],
              SizedBox(height :20,),
              if (_isLoading)
                Center(child : CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed :_isLogin ?_login :_register,
                  child :Text(_isLogin ?'Iniciar Sesión' :'Registrar'),
                  style :ElevatedButton.styleFrom(
                    padding :EdgeInsets.symmetric(vertical :15),
                    backgroundColor :Colors.white,
                    textStyle :TextStyle(color :Colors.black),
                    shape :RoundedRectangleBorder(
                      borderRadius :BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              SizedBox(height :20,),
              TextButton(
                onPressed :() { 
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content :
                      Text('Recuperación de contraseña')));
                },
                child :Text('¿Olvidaste tu contraseña?', style :
                    TextStyle(color :Colors.white)),
              ),
              SizedBox(height :20,),
              TextButton(
                onPressed :() { 
                  setState(() { 
                    _isLogin = !_isLogin; 
                  }); 
                },
                child :Text(_isLogin ?'¿No tienes cuenta? Regístrate' :'¿Ya tienes cuenta? Inicia sesión', style :
                    TextStyle(color :Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
