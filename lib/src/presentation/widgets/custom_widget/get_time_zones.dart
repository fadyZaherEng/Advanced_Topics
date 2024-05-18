import 'package:country_state_city/country_state_city.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:worldtime/worldtime.dart';

List<String> states = [];
List<dynamic> cities = [];
String _currentTime = "";

void _getTimeZone() async {
  cities = await getStatesOfCountry('IQ');
  for (var city in cities) {
    states.add(city.name.split(" ").first);
  }
  _getCurrentTime();
}

void _getCurrentTime() async {
  tz.initializeTimeZones();
  List<tz.Location>? locations;
  String region = "";
  for (String city in states) {
    locations = tz.timeZoneDatabase.locations.values
        .where((location) => location.name.contains(city))
        .toList();
    try {
      region = locations.first.name;
      break;
    } catch (e) {}
  }
  if (locations != null) {
    String? formattedTime;
    try {
      final location = tz.getLocation(region);
      final currentTime = tz.TZDateTime.now(location);
      formattedTime = DateFormat.jm().format(currentTime);
      _currentTime = formattedTime;
      //   setState(() {});
    } catch (e) {}
  } else {
    //  print('Timezone information not found for ${region}');
  }
}

void _getCurrentTimeBasedOnCity(String city) async {
  tz.initializeTimeZones();
  List<tz.Location> locations = tz.timeZoneDatabase.locations.values
      .where((location) => location.name.contains(city))
      .toList();
  // for (tz.Location location in tz.timeZoneDatabase.locations.values) {
  //   print(location.name);
  // }
  if (locations.isNotEmpty) {
    String? formattedTime;
    try {
      final location = tz.getLocation(locations.first.name);
      final currentTime = tz.TZDateTime.now(location);
      formattedTime = DateFormat.jm().format(currentTime);
    } catch (e) {}
    _currentTime = formattedTime!;
    //setState(() {});
  } else {
    print('Timezone information not found for $city');
  }
}

//to get region based mobile location then use it in time zone to get time
void _getRegionBasedMobileLocation() async {
  String region = await FlutterNativeTimezone.getLocalTimezone();
  List<String> regions = await FlutterNativeTimezone.getAvailableTimezones();
}

void _getRegionBasedMobileLocation2() async {
  List<Location> locations = await locationFromAddress("italia");
  print("gggggggggggggggggg${locations[0].latitude} ${locations[0].longitude}");
  final DateTime timeAmsterdamGeo = await Worldtime().timeByLocation(
    latitude: locations[0].latitude,
    longitude: locations[0].longitude,
  );
  print("timeAmsterdamGeo $timeAmsterdamGeo");
}

void _getCurrentTime2() async {
  tz.initializeTimeZones();
  List<String> regions = await FlutterNativeTimezone.getAvailableTimezones();
  List<tz.Location>? locations;
  String region = "";
  for (String city in states) {
    locations = tz.timeZoneDatabase.locations.values
        .where((location) => location.name.contains(city))
        .toList();
    try {
      region = locations.first.name;
      break;
    } catch (e) {}
  }
  if (locations != null) {
    String? formattedTime;
    try {
      final location = tz.getLocation(region);
      final currentTime = tz.TZDateTime.now(location);
      formattedTime = DateFormat.jm().format(currentTime);
      _currentTime = formattedTime;
      //setState(() {});
    } catch (e) {}
  } else {
    print('Timezone information not found for ${region}');
  }
}

String _currentCity = "";
void _getCurrentTime1() async {
  tz.initializeTimeZones();
  List<tz.Location>? locations;
  String region = "";
  for (String city in states) {
    if (city == _currentCity) {
      locations = tz.timeZoneDatabase.locations.values
          .where((location) => location.name.contains(city))
          .toList();
      try {
        region = locations.first.name;
        break;
      } catch (e) {}
    }
  }
  if (locations != null) {
    String? formattedTime;
    try {
      final location = tz.getLocation(region);
      final currentTime = tz.TZDateTime.now(location);
      formattedTime = DateFormat.jm().format(currentTime);
      _currentTime = formattedTime;
      //setState(() {});
    } catch (e) {}
  } else {
    print('Timezone information not found for ${region}');
  }
}
