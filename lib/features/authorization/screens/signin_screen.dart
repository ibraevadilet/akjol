import 'package:akjol/features/authorization/screens/signup_screen.dart';
import 'package:akjol/features/authorization/widget/logo.dart';
import 'package:akjol/features/authorization/widget/text_filed.dart';
import 'package:akjol/widgets/buttom_navigator.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isKeyboar = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimateGradient(
        primaryColors: const [
          Colors.pink,
          Colors.pinkAccent,
          Colors.white,
        ],
        secondaryColors: const [
          Colors.blue,
          Colors.blueAccent,
          Colors.white,
        ],
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (!isKeyboar) Logo(),
                  SizedBox(
                    height: 30,
                  ),
                  textField(
                      'Введите емайл', Icons.person_outlined, false, _emailController),
                  SizedBox(
                    height: 20,
                  ),
                  textField(
                      'Введите пароль', Icons.lock_outlined, false, _passwordController),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Нет учетной записи?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                    width: 5,
                  ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            'Зарегистрироваться',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: double.maxFinite,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
        child: AnimatedContainer(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          height: 60,
          width: isKeyboar ? 60 : 400,
          duration: Duration(milliseconds: 800),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    isKeyboar ? 190 : 30,
                  ),
                )),
            onPressed: () {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text)
                  .then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigatorScreen()))
                      .onError(
                          (error, stackTrace) => print('${error.toString()}')));
            },
            child: isKeyboar
                ? Container(
                    child: Icon(
                      Icons.arrow_forward,
                    ),
                  )
                : Container(
                    child: Text(
                      "Войти",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Sign Up')],
    );
  }
}
