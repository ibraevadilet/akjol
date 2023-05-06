import 'package:akjol/core/save_person_data.dart';
import 'package:akjol/features/home/models/plase_model.dart';
import 'package:akjol/features/home/plase_repo.dart/plase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'plases_state.dart';
part 'plases_cubit.freezed.dart';

class PlasesCubit extends Cubit<PlasesState> {
  PlasesCubit(this.repo) : super(const PlasesState.loading());

  final GetPlaseRepo repo;

  Future<void> getPlase() async {
    emit(const PlasesState.loading());
    try {
      final plases = await repo.getPlase();

      emit(PlasesState.success(plases));
    } catch (e) {
      emit(PlasesState.error(e.toString()));
    }
  }

  Future<void> getMyPlase() async {
    emit(const PlasesState.loading());
    try {
      final uId = await SavePersonData.getUserId();
      final plases = await repo.getMyPlase();
      final role = await SavePersonData.getRole();
      if (role == 'Граждан') {
        plases.removeWhere((e) => e.userId != uId);
      }

      emit(PlasesState.success2(plases));
    } catch (e) {
      emit(PlasesState.error(e.toString()));
    }
  }
}
