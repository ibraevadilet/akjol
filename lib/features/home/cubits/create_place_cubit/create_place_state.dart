part of 'create_place_cubit.dart';

@freezed
class CreatePlaceState with _$CreatePlaceState {
  const factory CreatePlaceState.initial() = _Initial;
  const factory CreatePlaceState.loading() = _Loading;
  const factory CreatePlaceState.error(String error) = _Error;
  const factory CreatePlaceState.success() = _Success;

  const CreatePlaceState._();
  bool get isLoading => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}
