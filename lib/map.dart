import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './models/Exam.dart';

class TermMap extends StatefulWidget {
  final List<Exam> exams;
  const TermMap(this.exams);

  @override
  _TermMapState createState() => _TermMapState(this.exams);
}

class _TermMapState extends State<TermMap> {
  List<Exam> exams;
  GoogleMapController? mapController;
  LatLng? showLocation = null;
  bool initialLocation = false;
  final Set<Marker> markers = new Set();

  _TermMapState(this.exams);

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => this._getData());
  }

  Set<Marker> _getData() {
    setState(() {
      this.exams.forEach((exam) => {
        if (exam.location != null && exam.lat != null && exam.long != null)
          {
            this.markers.add(Marker(
              markerId: MarkerId(exam.name! + exam.lat!),
              position: LatLng(double.parse(exam.lat!), double.parse(exam.long!)), //position of marker
              infoWindow: InfoWindow(
                title: exam.name! + ' : ' + exam.time!.format(context),
                snippet: exam.location,
              ),
              icon: BitmapDescriptor.defaultMarker,
            )),
            if (this.showLocation == null)
              {
                this.showLocation = LatLng(double.parse(exam.lat!), double.parse(exam.long!)),
                this.initialLocation = true
              }
          }
      });
    });
    return this.markers;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms map'),
      ),
      body: initialLocation
          ? GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: showLocation!,
          zoom: 15.0,
        ),
        markers: _getData(),
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      )
          : Center(child: Text("Loading...")),
    );
  }
}
