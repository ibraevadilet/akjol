part of 'plases_cubit.dart';

@freezed
class PlasesState with _$PlasesState {
  const factory PlasesState.loading() = _Loading;
  const factory PlasesState.error(String error) = _Error;
  const factory PlasesState.success(Set<Marker> model) = _Success;
  const factory PlasesState.success2(List<PlaseModel> model) = _Success2;
}
