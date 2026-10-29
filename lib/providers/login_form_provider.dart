import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier  {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm(){
    final isValid = formKey.currentState?.validate() ?? false;
    if(isValid){
      email = email.trim();
      password = password.trim();
    }
    return isValid;
  }
}