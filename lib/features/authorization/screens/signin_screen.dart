import 'package:akjol/core/save_person_data.dart';
import 'package:akjol/features/authorization/screens/signup_screen.dart';
import 'package:akjol/features/authorization/widget/logo.dart';
import 'package:akjol/features/authorization/widget/text_filed.dart';
import 'package:akjol/widgets/buttom_navigator.dart';
import 'package:akjol/widgets/spaces.dart';
import 'package:akjol/widgets/styled_toasts.dart';
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
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboar = MediaQuery.of(context).viewInsets.bottom != 0;
    bool _isLoading = false;

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
                  textField('Введите емайл', Icons.person_outlined, false,
                      _emailController),
                  SizedBox(
                    height: 20,
                  ),
                  textField('Введите пароль', Icons.lock_outlined, true,
                      _passwordController),
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
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Зарегистрироваться',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: AnimatedContainer(
        height: 60,
        width: isKeyboar ? 60 : getWidth(context),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
        duration: Duration(milliseconds: 800),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  isKeyboar ? 190 : 30,
                ),
              )),
          onPressed: () async {
            if (_emailController.text.isEmpty ||
                _passwordController.text.isEmpty) {
              showErrorSnackBar('Поле не должно быть пустным');
            } else if (_passwordController.text.length < 6) {
              showErrorSnackBar('Пароль должен содержать минимум 6 символов');
            } else {
              try {
                setState(() {
                  _isLoading = true;
                });
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text);
                setState(() {
                  _isLoading = false;
                });
                await SavePersonData.setUserId();
                await SavePersonData.setEmail(_emailController.text);
                showSuccessSnackBar('Добро пожаловать');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigatorScreen(),
                  ),
                );
              } on FirebaseAuthException catch (e) {
                setState(() {
                  _isLoading = false;
                });
                if (e.code == 'user-not-found') {
                  showErrorSnackBar('Не верный email');
                } else if (e.code == 'wrong-password') {
                  showErrorSnackBar('Не верный пароль');
                }
              }
            }
          },
          child: _isLoading == true
              ? CircularProgressIndicator()
              : isKeyboar
                  ? Container(
                      child: Icon(
                        Icons.arrow_forward,
                      ),
                    )
                  : _isLoading == true
                      ? CircularProgressIndicator()
                      : Container(
                          child: Text(
                            "Войти",
                            style: TextStyle(fontSize: 18),
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
