import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void>  searchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    }
  }

  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static Future<void>  searchNearbyHospital() async {
    var _logger = Logger();

    Position currentPosition = await _determinePosition();
    //https://www.google.com/maps/search/hospital/@-6.1698361,106.7834279,13.07z
    String googleUrl = "https://www.google.com/maps/search/hospital/@" + currentPosition.latitude.toString() + ',' + currentPosition.longitude.toString();
    Uri param = Uri.parse(googleUrl);

    _logger.d(googleUrl);

    if (await canLaunchUrl(param)) {
      await launchUrl(param);
    } else {
      _logger.e('failed to launch : ' + googleUrl);
    }
  }

  static Future<void> launchEmegencyCaller() async {
    var _logger = Logger();

    const url = "tel:112";
    Uri param = Uri.parse(url);

    if (await canLaunchUrl(param)) {
      await launchUrl(param);
    } else {
      _logger.e('failed to launch : $url');
      throw 'Could not launch $url';
    }
  }
}