import 'dart:developer';
import 'dart:typed_data';

import 'package:arabic_screen/enums/place_type.dart';
import 'package:flutter/services.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image/image.dart' as img;

const kGoogleApiKey = "AIzaSyBIraTQ2S0CbHhbY_UInYv3UoyauQVqsc8";

class Maps {
  static final Maps shared = Maps();

  Future<List<PlacesSearchResult>?> search({required String key}) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

    try {
      // final PlacesSearchResponse response = await places.searchNearbyWithRankBy(
      //     Location(lat: 24.774265, lng: 46.738586), "distance",
      //     keyword: "", type: key);

      final PlacesSearchResponse response = await places.searchNearbyWithRadius(
          Location(lat: 24.774265, lng: 46.738586), 50000,
          type: key);

      return response.results;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<PlacesSearchResult>?> searchAddress({required String key}) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );

    try {
      final PlacesSearchResponse response = await places.searchNearbyWithRadius(
          Location(lat: 24.774265, lng: 46.738586), 50000,
          keyword: key);

      return response.results;
    } catch (e) {
      log(e.toString());
    }

    return [];
  }

  Future<PlaceDetails?> displayPrediction(String? placeId) async {
    if (placeId != null) {
      try {
        GoogleMapsPlaces _places = GoogleMapsPlaces(
          apiKey: kGoogleApiKey,
          apiHeaders: await GoogleApiHeaders().getHeaders(),
        );
        PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(placeId);
        return detail.result;
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<BitmapDescriptor> getIconPlace({required PlaceType placeType}) async {
    ByteData donebytes = await rootBundle.load('assets/images/done_marker.png');
    Uint8List doneU8 = donebytes.buffer
        .asUint8List(donebytes.offsetInBytes, donebytes.lengthInBytes);
    List<int> doneListInt = doneU8.cast<int>();

    img.Image doneImg = img.decodePng(doneListInt)!;

    switch (placeType) {
      case PlaceType.restaurant:
        img.colorOffset(
          doneImg,
          red: placeType.colorPlace.red,
          green: placeType.colorPlace.green,
          blue: placeType.colorPlace.blue,
        );
        break;
      case PlaceType.garden:
        img.colorOffset(
          doneImg,
          red: placeType.colorPlace.red,
          green: placeType.colorPlace.green,
          blue: placeType.colorPlace.blue,
        );
        break;
      case PlaceType.cafe:
        img.colorOffset(
          doneImg,
          red: placeType.colorPlace.red,
          green: placeType.colorPlace.green,
          blue: placeType.colorPlace.blue,
        );
        break;
      case PlaceType.library:
        img.colorOffset(
          doneImg,
          red: placeType.colorPlace.red,
          green: placeType.colorPlace.green,
          blue: placeType.colorPlace.blue,
        );
        break;
    }

    doneImg = img.copyResize(doneImg, width: 100);

    final Uint8List doneIconColorful =
        Uint8List.fromList(img.encodePng(doneImg));
    return BitmapDescriptor.fromBytes(doneIconColorful);
  }
}
