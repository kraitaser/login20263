import 'package:flutter/material.dart';
import 'package:login20263/providers/login_form_provider.dart';
import 'package:login20263/services/auth_service.dart';
import 'package:login20263/services/notifications_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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

class _LoginForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Center(
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 96, 108, 93),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: loginForm.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16.0),
                  Container(
                    width: size.width * 0.80,
                    height: size.height * 0.17,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/Casio-logo.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.80,
                    height: size.height * 0.5,
                    alignment: Alignment.center,
                  ),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    onChanged: (value) => loginForm.email = value,
                    decoration: const InputDecoration(
                      hintText: 'ejemplo@test.com',
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 255, 244, 244),
                      ),
                    ),
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = RegExp(pattern);
                      return regExp.hasMatch(value ?? '')
                          ? null
                          : 'El valor ingresado no es un correo electronico';
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    autocorrect: false,
                    obscureText: true,
                    onChanged: (value) => loginForm.password = value,
                    decoration: const InputDecoration(
                      hintText: '***********',
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 255, 244, 244),
                      ),
                    ),
                    validator: (value) {
                      return (value != null && value.length >= 8)
                          ? null
                          : 'La contraseña debe de ser de mas de 7 caraceres';
                    },
                  ),
                  ElevatedButton(
                    onPressed: loginForm.isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            loginForm.email = _emailController.text.trim();
                            loginForm.password = _passwordController.text;

                            final authService = Provider.of<AuthService>(context, listen: false);
                            if (!loginForm.isValidForm()) return;

                            loginForm.isLoading = true;
                            final String? errorMessage = await authService.login(
                              loginForm.email,
                              loginForm.password,
                            );

                            if (errorMessage == null) {
                              Navigator.pushReplacementNamed(context, 'home');
                            } else {
                              NotificationsService.showSnackbar(errorMessage);
                              loginForm.isLoading = false;
                            }
                          },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 244, 244),
                      ),
                    ),
                    child: const Text(
                      'Iniciar sesion',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 96, 100, 93),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 244, 244),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'register', arguments: '');
                    },
                    child: const Text(
                      'Registrate',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 96, 100, 93),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}