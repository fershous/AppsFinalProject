import 'package:final_project/controllers/auth_controller.dart';
import 'package:final_project/services/auth_exception_handler.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:final_project/enums/auth_result_status.dart';
import 'package:final_project/services/firebase_auth_helper.dart';

final authController = Get.find<AuthController>();

late AuthResultStatus _status;
FirebaseAuth _auth = FirebaseAuth.instance;
User? _user;

final TextEditingController emailController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Login', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40)),
              Text(''),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0
                    )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0
                    )
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: TextButton(
                  onPressed: () => {
                    if(emailController.value.text != '' || passwordController.value.text != '') {
                      _login(emailController.value.text, passwordController.value.text),
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: Colors.white)
                        ],
                      )
                    )
                  ),
                ),
              ),
              Row(
                children: [
                  Text('¿Eres nuevo?'),
                  TextButton(
                    onPressed: () => {},
                    child: Text('Crea una cuenta', style: TextStyle(color: Colors.red[400]))
                  )
                ]
              ),
            ]
          ),
        ),
      ),
    );
  }

  dynamic _login(String email, String pass) async { 
    
    _status = await FirebaseAuthHelper().login(email: email, pass: pass);

    if( _status == AuthResultStatus.successful) {
      _user = _auth.currentUser;
      authController.setUser(_user!);
      Get.offNamed('home');
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(_status);
      print(errorMsg);
    }

  }

}