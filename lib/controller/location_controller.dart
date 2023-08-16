import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class LatLonController extends GetxController {
  RxDouble lat = 0.0.obs;
  RxDouble lon = 0.0.obs;
  dynamic data = 0;
  String city = "";
  String country = '';
  RxDouble temp = 0.0.obs;
  RxDouble aqi = 0.0.obs;

  void setAqi(value) {
    aqi.value = value;
    print("printing aqi from controller");
    print(aqi);
  }

  void setTemp(value) {
    temp.value = value;
  }

  void setLatLon(la, lo) {
    print(la);
    print(lo);
    lat.value = la;
    lon.value = lo;
  }

  addToList() {}

  setCity(c, i) {
    print(city);
    city = c;
    country = i;
  }

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currenPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // setState(() {
      //   lat = currenPostion.latitude;
      //   lon = currenPostion.longitude;
      // });

      setLatLon(currenPostion.latitude, currenPostion.longitude);
      print("current lat lon" + lat.toString() + " " + lon.toString());
      List<Placemark> placemarks =
          await placemarkFromCoordinates(lat.value, lon.value);
      Placemark place = placemarks[0];

      country = place.isoCountryCode.toString();
      city = place.locality.toString();
    }
  }
}
