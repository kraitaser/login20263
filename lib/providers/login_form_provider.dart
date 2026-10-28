import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier  {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  bool isLoading = false;
  bool get _isLoading => isLoading;
  set _isLoading(bool value){
    isLoading = value;
    notifyListeners();
  }

  bool isValidForm(){
    print(formKey.currentState?.validate());
    print('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }
}