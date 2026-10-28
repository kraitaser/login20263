import 'package:flutter/material.dart';
import 'package:login20263/screens/login.dart';
import 'package:login20263/screens/principal.dart';
import 'package:login20263/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context,listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            if(!snapshot.hasData) return Text('');
            if(snapshot.data == ''){
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginPage(),
                    transitionDuration: Duration(seconds:0)
                  )
                );
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => PrincipalScr(),
                    transitionDuration: Duration(seconds:0)
                  )
                );
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}