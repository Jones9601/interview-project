import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interviewproject/model/first-task.model.dart';
import 'package:interviewproject/screen/loggin.screen.dart';

import '../utils/http-utils.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  firsttask data;
  DetailsPage({super.key, required this.data});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng _center = const LatLng(0, 0);
  LatLng position = const LatLng(0, 0);
  Set<Marker> _markers = <Marker>{};

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    var lat = double.parse(
        widget.data.results?.first.location?.coordinates?.latitude ?? '0');
    var long = double.parse(
        widget.data.results?.first.location?.coordinates?.latitude ?? '0');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Details page'),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, widget.data);
            },
            child: const Icon(Icons.backpack)),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, long),
                zoom: 11.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('jones'),
                  position: LatLng(lat, long),
                  infoWindow: const InfoWindow(
                    title: 'jones',
                  ),
                  // icon: customIcon,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                ),
              },
              myLocationEnabled: true,
              compassEnabled: false,
              tiltGesturesEnabled: false,
            ),
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.focused)) return Colors.red;
                return null; // Defer to the widget's default.
              }),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Login'),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            widget.data.results?.first.name?.first.toString() ??
                                ''),
                        Text(widget.data.results?.first.name?.last.toString() ??
                            ''),
                        Text(
                            '${widget.data.results?.first.location?.street?.name ?? ''} ${widget.data.results?.first.location?.city ?? ''} ${widget.data.results?.first.location?.state ?? ''}'),
                        Text(
                            '${widget.data.results?.first.location?.coordinates?.latitude ?? ''} ${widget.data.results?.first.location?.coordinates?.longitude ?? ''}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
