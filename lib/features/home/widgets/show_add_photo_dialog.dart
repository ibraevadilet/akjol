import 'package:akjol/features/home/cubits/create_place_cubit/create_place_cubit.dart';
import 'package:akjol/features/home/plase_repo.dart/plase_repo.dart';
import 'package:akjol/features/home/widgets/add_photo_widget.dart';
import 'package:akjol/helpers/app_colors.dart';
import 'package:akjol/widgets/custom_button.dart';
import 'package:akjol/widgets/custom_text_field.dart';
import 'package:akjol/widgets/styled_toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showAddAdressDialog(
  BuildContext mainContext,
  String lat,
  String lon,
  Function() onSuccess,
) async {
  String adress = '';
  String comment = '';
  String? image;
  bool isAllEntred() =>
      adress.isNotEmpty && comment.isNotEmpty && image != null;
  await showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    isScrollControlled: true,
    context: mainContext,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    onChanged: (adressFrom) {
                      setState(() {
                        adress = adressFrom;
                      });
                    },
                    hintText: 'Адрес',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    onChanged: (commentFrom) {
                      setState(() {
                        comment = commentFrom;
                      });
                    },
                    hintText: 'Укажите проблему',
                    maxLines: 5,
                    minLines: 1,
                  ),
                  const SizedBox(height: 20),
                  AddPhotoWidget(
                    onSelected: (imageFrom) {
                      setState(() {
                        image = imageFrom;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocProvider(
                    create: (context) =>
                        CreatePlaceCubit(GetPlaseRepoRepoImpl()),
                    child: BlocConsumer<CreatePlaceCubit, CreatePlaceState>(
                      listener: (context, state) {
                        state.whenOrNull(
                          success: () {
                            Navigator.pop(context);
                            showSuccessSnackBar('Успешно отправлен!');
                            onSuccess();
                          },
                        );
                      },
                      builder: (context, state) {
                        return CustomButton(
                          isLoading: state.isLoading,
                          color: isAllEntred()
                              ? AppColors.color4CADEABlue
                              : AppColors.color4CADEABlue.withOpacity(
                                  0.5,
                                ),
                          text: 'Отправить',
                          onPressed: () async {
                            if (isAllEntred()) {
                              await context
                                  .read<CreatePlaceCubit>()
                                  .createPlase(
                                    adress,
                                    comment,
                                    image!,
                                    lat,
                                    lon,
                                  );
                            } else {
                              showErrorSnackBar('Заполните все поля');
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
