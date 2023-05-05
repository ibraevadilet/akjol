import 'dart:io';
import 'dart:typed_data';

import 'package:akjol/features/home/models/plase_model.dart';
import 'package:akjol/features/home/plase_repo.dart/upload_image.dart';
import 'package:akjol/features/home/widgets/get_bytes_from_asset.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GetPlaseRepo {
  Future<Set<Marker>> getPlase();
  Future<List<PlaseModel>> getMyPlase();
  Future<void> createPlase(PlaseModel plase);
}

class GetPlaseRepoRepoImpl implements GetPlaseRepo {
  @override
  Future<void> createPlase(PlaseModel plaseModel) async {
    print(plaseModel);
    try {
      String url = await uploadImage(File(plaseModel.image));
      final plase = FirebaseDatabase.instance.ref('plases');
      await plase.push().set(plaseModel.copyWith(image: url).toJson());
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<Set<Marker>> getPlase() async {
    final plases = <PlaseModel>[];
    Set<Marker> markers = {};
    final snapshot = await FirebaseDatabase.instance.ref('plases').get();

    if (snapshot.value != null) {
      final map = snapshot.value as Map<dynamic, dynamic>;

      map.forEach((key, value) {
        value['id'] = key;
        final plase = PlaseModel.fromJson(value);
        plases.add(plase);
      });

      final Uint8List customMarker = await getBytesFromAsset(
        path: 'assets/images/restourant_geo_icon.png',
        width: 100,
      );

      for (var e in plases) {
        markers.add(
          Marker(
            markerId: const MarkerId('restLocaction'),
            icon: BitmapDescriptor.fromBytes(customMarker),
            infoWindow: InfoWindow(
              onTap: () {
                print('object');
              },
              title: e.adress,
              snippet: '${e.lat},  ${e.lan}\n${e.comments}',
            ),
            position: LatLng(
              double.parse(e.lat),
              double.parse(e.lan),
            ),
          ),
        );
      }
    }
    return markers;
  }

  @override
  Future<List<PlaseModel>> getMyPlase() async {
    final plases = <PlaseModel>[];

    final snapshot = await FirebaseDatabase.instance.ref('plases').get();

    if (snapshot.value != null) {
      final map = snapshot.value as Map<dynamic, dynamic>;

      map.forEach((key, value) {
        value['id'] = key;
        final plase = PlaseModel.fromJson(value);
        plases.add(plase);
      });
    }
    return plases;
  }
}
