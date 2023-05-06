import 'package:akjol/core/save_person_data.dart';
import 'package:akjol/features/home/cubits/plases_cubit/plases_cubit.dart';
import 'package:akjol/features/home/plase_repo.dart/plase_repo.dart';
import 'package:akjol/features/profile/widgets/review_widget.dart';
import 'package:akjol/features/role/role_screen.dart';
import 'package:akjol/helpers/app_text_styles.dart';
import 'package:akjol/widgets/app_error_text.dart';
import 'package:akjol/widgets/app_indicator.dart';
import 'package:akjol/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            FutureBuilder(
              future: SavePersonData.getName(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: AppTextStyles.s16W400(),
                  );
                }
                return const Text('');
              },
            ),
            SizedBox(height: 12),
            FutureBuilder(
              future: SavePersonData.getEmail(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: AppTextStyles.s16W400(),
                  );
                }
                return const Text('');
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocProvider(
                create: (context) =>
                    PlasesCubit(GetPlaseRepoRepoImpl())..getMyPlase(),
                child: BlocBuilder<PlasesCubit, PlasesState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const AppIndicator(),
                      loading: () => const AppIndicator(),
                      error: (error) => AppErrorText(
                        error: error,
                        onPress: () => context.read<PlasesCubit>().getPlase(),
                      ),
                      success2: (model) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: model.isEmpty
                            ? Center(
                                child: const Text(
                                  'Вы еще не добавили адрес\nПожалуйста добавьте!',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) =>
                                    MyReviewsWidget(
                                  model: model[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemCount: model.length,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                text: 'Выйти',
                onPressed: () async {
                  await SavePersonData.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoleScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
