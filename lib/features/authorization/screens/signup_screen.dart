import 'package:akjol/core/save_person_data.dart';
import 'package:akjol/features/authorization/widget/text_filed.dart';
import 'package:akjol/widgets/buttom_navigator.dart';
import 'package:akjol/widgets/spaces.dart';
import 'package:akjol/widgets/styled_toasts.dart';
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
  dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                        textField('Введите имя', Icons.person_outlined, false,
                            _userNameController),
                        SizedBox(
                          height: 20,
                        ),
                        textField('Введите email', Icons.person_outlined, false,
                            _emailController),
                        SizedBox(
                          height: 20,
                        ),
                        textField('Введите пароль', Icons.lock_outlined, true,
                            _passwordController),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ))),
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
            if (_userNameController.text.isEmpty ||
                _emailController.text.isEmpty ||
                _passwordController.text.isEmpty) {
              showErrorSnackBar('Поле не должно быть пустным');
            } else if (_passwordController.text.length < 6) {
              showErrorSnackBar('Пароль должен содержать минимум 6 символов');
            } else {
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text,
              );
              await SavePersonData.setName(_userNameController.text);
              await SavePersonData.setEmail(_emailController.text);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavigatorScreen(),
                ),
              );
              showSuccessSnackBar('Вы успешно зарегистрировались!');
            }
          },
          child: isKeyboar
              ? Container(
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                )
              : Container(
                  child: Text(
                    "Зарегистрироваться",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
