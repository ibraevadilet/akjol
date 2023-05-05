import 'package:akjol/features/home/cubits/plases_cubit/plases_cubit.dart';
import 'package:akjol/features/home/plase_repo.dart/plase_repo.dart';
import 'package:akjol/features/profile/widgets/review_widget.dart';
import 'package:akjol/widgets/app_error_text.dart';
import 'package:akjol/widgets/app_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  child: ListView.separated(
                    itemBuilder: (context, index) => MyReviewsWidget(
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
    );
  }
}
