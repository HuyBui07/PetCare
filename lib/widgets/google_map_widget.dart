import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class GoogleMapWidget extends StatefulWidget {
  double lat, long;
  String name;
  GoogleMapWidget(
      {Key? key, required this.lat, required this.long, required this.name})
      : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  LatLng? _currentPosition;
  PointLatLng? _currentPositionPoint;

  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController controller;
  @override
  void initState() {
    print('lat: ${widget.lat}');
    print('long: ${widget.long}');
    // TODO: implement initState
    super.initState();
    _markers.add(
      Marker(
          markerId: const MarkerId('1'),
          position: LatLng(widget.lat, widget.long),
          infoWindow: InfoWindow(
            title: widget.name,
          )),
    );
    updateMap();
  }

  final List<Marker> _markers = [];

// created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  updateMap() async {
    await getUserCurrentLocation().then((value) => {
          print(value.latitude.toString() + " " + value.longitude.toString()),

          // marker added for current users location
          _markers.add(Marker(
            markerId: MarkerId("2"),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(
              title: 'My Current Location',
            ),
          )),

          // specified current users location
          // setState(() {
          //   camPosition = CameraPosition(
          //     target: LatLng(value.latitude, value.longitude),
          //     zoom: 14,
          //   );
          // }),
          setState(() {
            _currentPosition = LatLng(value.latitude, value.longitude);
            _currentPositionPoint =
                PointLatLng(value.latitude, value.longitude);

            //_isLoading = false;
          }),
          if (_currentPosition != null) {getPolyPoints()},
        });
  }

//drawing route
  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyBKj53D-20Zqljwf3ztrJEy18wemx_Gny0',
        _currentPositionPoint!,
        PointLatLng(widget.lat, widget.long));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) => setState(() {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _currentPosition != null
          ? GoogleMap(
              // on below line setting camera position
              initialCameraPosition: CameraPosition(
                  target: _currentPosition!, zoom: 12, tilt: 0.0),
              // on below line we are setting markers on the map
              markers: Set<Marker>.of(_markers),
              // on below line specifying map type.
              mapType: MapType.normal,
              // on below line setting user location enabled.
              myLocationEnabled: true,
              // on below line setting compass enabled.
              compassEnabled: true,
              // on below line specifying controller on map complete.
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              // drawing poluline
              polylines: {
                Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinates,
                    width: 4,
                    color: AppColors.violet)
              },
              // polygons: {_kPolygon},
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
