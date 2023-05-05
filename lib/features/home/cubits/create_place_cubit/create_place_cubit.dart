import 'package:akjol/core/date_format.dart';
import 'package:akjol/core/save_person_data.dart';
import 'package:akjol/features/home/models/plase_model.dart';
import 'package:akjol/features/home/plase_repo.dart/plase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_place_state.dart';
part 'create_place_cubit.freezed.dart';

class CreatePlaceCubit extends Cubit<CreatePlaceState> {
  CreatePlaceCubit(this.repo) : super(const CreatePlaceState.initial());

  final GetPlaseRepo repo;

  Future<void> createPlase(
    String adress,
    String comment,
    String image,
    String lat,
    String lon,
  ) async {
    print(image);
    emit(const CreatePlaceState.loading());
    String userId = await SavePersonData.getUserId();

    if (userId.isEmpty) {
      await SavePersonData.setUserId();
      userId = await SavePersonData.getUserId();
    }

    try {
      await repo.createPlase(
        PlaseModel(
          image: image,
          date: dayFormat.format(DateTime.now()),
          comments: comment,
          lat: lat,
          lan: lon,
          userId: userId,
          tittle: 'Title',
          adress: adress,
        ),
      );
      emit(const CreatePlaceState.success());
    } catch (e) {
      emit(CreatePlaceState.error(e.toString()));

      throw Exception(e);
    }
  }
}
