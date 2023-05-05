import 'package:akjol/features/home/cubits/plases_cubit/plases_cubit.dart';
import 'package:akjol/features/home/plase_repo.dart/plase_repo.dart';
import 'package:akjol/features/home/widgets/get_local_positin.dart';
import 'package:akjol/features/home/widgets/show_add_photo_dialog.dart';
import 'package:akjol/widgets/app_error_text.dart';
import 'package:akjol/widgets/app_indicator.dart';
import 'package:akjol/widgets/custom_button.dart';
import 'package:akjol/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlasesCubit(GetPlaseRepoRepoImpl())..getPlase(),
      child: Scaffold(
        body: Stack(
          children: [
            BlocConsumer<PlasesCubit, PlasesState>(
              listener: (context, state) => state.whenOrNull(
                success: (model) {
                  if (model.isNotEmpty) {
                    markers.clear();
                    markers.addAll(model);
                  }
                  return null;
                },
              ),
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const AppIndicator(),
                  loading: () => const AppIndicator(),
                  error: (error) => AppErrorText(
                    error: error,
                    onPress: () => context.read<PlasesCubit>().getPlase(),
                  ),
                  success: (model) => FutureBuilder(
                    future: getLocalPositin(),
                    builder: (context, AsyncSnapshot<Position?> snapshot) {
                      if (snapshot.hasData) {
                        return GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              snapshot.data!.latitude,
                              snapshot.data!.longitude,
                            ),
                            zoom: 16,
                          ),
                          markers: markers,
                          zoomControlsEnabled: true,
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            googleMapController = controller;
                          },
                        );
                      }
                      return SizedBox(
                        height: getHeight(context),
                        child: const AppIndicator(),
                      );
                    },
                  ),
                );
              },
            ),
            Positioned(
              bottom: 12,
              child: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    text: 'Добавить адрес',
                    width: getWidth(context) - 32,
                    onPressed: () async {
                      final placeLocale = await getLocalPositin();
                      await showAddAdressDialog(
                        context,
                        placeLocale.latitude.toString(),
                        placeLocale.longitude.toString(),
                        () {
                          context.read<PlasesCubit>().getPlase();
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
