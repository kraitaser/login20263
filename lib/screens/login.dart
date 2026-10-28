import 'package:flutter/material.dart';
import 'package:login20263/providers/login_form_provider.dart';
import 'package:login20263/services/auth_service.dart';
import 'package:login20263/services/notifications_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const new({super.key});

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
          child: _LoginForm(),
        ),
      )
    );
  }
}

class _LoginForm extends StatelessWidget{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  _LoginForm({super.key});

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Center(
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 96, 108, 93)
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height:16.0,),
                Container(
                  width: size.width * 0.80,
                  height: size.height * 0.17,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage( 'assets/Casio-logo.jpg'), 
                      fit: BoxFit.fill
                    )
                  )
                ),
                Container(
                  width: size.width * 0.80,
                  height : size.height *0.50,
                  alignment: Alignment.center,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese su correo',
                    labelText: 'Correo',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight:FontWeight.w500,
                    ),
                  ),
                  validator: (value){
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = RegExp(pattern);
                    return regExp.hasMatch(value ?? '') ? null : 'el valor ingresado no es un correo';
                  }
                ),
                TextFormField(
                  controller: _passwordController,
                  autocorrect: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: '********',
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight:FontWeight.w500,
                    ),
                  ),
                  validator: (value){
                    return (value != null && value.length >=8) ? null : 'la contrase;a debe de ser de mass de 8 o mas caracteres';
                  },
                ),
                ElevatedButton(
                  onPressed: loginForm.isLoading ? null : ()async {
                    FocusScope.of(context).unfocus();
                    final authService = Provider.of<AuthService>(context, listen: false);
                    if(!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;

                    final String? errorMessage = await authService.login(loginForm.email, loginForm.password);
                    if(errorMessage == null){
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      NotificationsService.showSnackbar(errorMessage);
                      loginForm.isLoading = false;
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 244, 244),),   
                  ),
                  child: const Text(
                    'iniciar sesion',
                    style: TextStyle(
                      color: Color.fromARGB(255, 96, 108, 93),
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(height: 16.0,),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 244, 244),),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'register', arguments: '');
                  },
                  child: const Text(
                    'registrate',
                    style: TextStyle(
                      color: Color.fromARGB(255, 96, 100, 93),
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    )
                  )
                )
              ]
            ) 
          ,)
        )
      )
    );
  } 
}