import 'package:akjol/features/authorization/widget/text_filed.dart';
import 'package:akjol/widgets/buttom_navigator.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isKeyboar = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Регистрация', style: TextStyle(fontSize: 24)),
      ),
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
        child: SafeArea(
          child: SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        textField('Введите имя', Icons.mail, false,
                            _userNameController),
                        SizedBox(
                          height: 20,
                        ),
                        textField('Введите емайл', Icons.mail, false,
                            _emailController),
                        SizedBox(
                          height: 20,
                        ),
                        textField('Введите пароль', Icons.mail, true,
                            _passwordController),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ))),
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
                  .createUserWithEmailAndPassword(
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
}
