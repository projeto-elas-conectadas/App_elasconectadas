import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AdsApi
void main() {
  final instance = Openapi().getAdsApi();

  group(AdsApi, () {
    //Future adsControllerCreateAd(CreateAdDto createAdDto) async
    test('test adsControllerCreateAd', () async {
      // TODO
    });

    //Future adsControllerDeleteAdById(String id) async
    test('test adsControllerDeleteAdById', () async {
      // TODO
    });

    //Future adsControllerGetAdById(String id) async
    test('test adsControllerGetAdById', () async {
      // TODO
    });

    //Future adsControllerGetAllAds() async
    test('test adsControllerGetAllAds', () async {
      // TODO
    });

    //Future adsControllerPatchAd(String id, UpdateAdDto updateAdDto) async
    test('test adsControllerPatchAd', () async {
      // TODO
    });

  });
}
