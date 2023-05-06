import 'package:akjol/core/save_person_data.dart';
import 'package:akjol/features/authorization/screens/signin_screen.dart';
import 'package:akjol/helpers/app_colors.dart';
import 'package:akjol/helpers/app_text_styles.dart';
import 'package:akjol/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  String isGrajdan = 'Граждан';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Выберите роль',
                style: AppTextStyles.s19W700(),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  RoleWidget(
                    role: 'Граждан',
                    onTap: () {
                      setState(() {
                        isGrajdan = 'Граждан';
                      });
                    },
                    isActive: isGrajdan == 'Граждан',
                  ),
                  SizedBox(width: 12),
                  RoleWidget(
                    role: 'Админ',
                    onTap: () {
                      setState(() {
                        isGrajdan = 'Админ';
                      });
                    },
                    isActive: isGrajdan == 'Админ',
                  ),
                ],
              ),
              Spacer(),
              CustomButton(
                text: 'Далее',
                onPressed: () async {
                  await SavePersonData.setRole(isGrajdan);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthorizationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleWidget extends StatelessWidget {
  const RoleWidget({
    super.key,
    required this.role,
    required this.onTap,
    required this.isActive,
  });

  final String role;
  final Function() onTap;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive ? AppColors.color4CADEABlue : Colors.grey,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(role),
              ),
              CircleAvatar(
                backgroundColor:
                    isActive ? AppColors.color4CADEABlue : Colors.grey,
                radius: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
