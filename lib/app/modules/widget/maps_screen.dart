import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  final Function(String) onLocationSelected;
  const MapsScreen({super.key, required this.onLocationSelected});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController mapController;
  LatLng? lastMapPosition;
  bool isMapCreated = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lastMapPosition = LatLng(position.latitude, position.longitude);
    });
    if (isMapCreated) {
      mapController.animateCamera(CameraUpdate.newLatLng(lastMapPosition!));
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      isMapCreated = true;
    });
    if (lastMapPosition != null) {
      mapController.animateCamera(CameraUpdate.newLatLng(lastMapPosition!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pilih Alamat",
          style: GoogleFonts.roboto(),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            buildingsEnabled: true,
            trafficEnabled: true,
            compassEnabled: true,
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: lastMapPosition ?? const LatLng(0.0, 0.0),
              zoom: 15.0,
            ),
            markers: {
              if (lastMapPosition != null)
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: lastMapPosition!,
                )
            },
            onTap: (position) {
              setState(() {
                lastMapPosition = position;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () async {
                  if (lastMapPosition != null) {
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                      lastMapPosition!.latitude,
                      lastMapPosition!.longitude,
                    );

                    if (placemarks.isNotEmpty) {
                      Placemark place = placemarks[0];
                      String fullAddress =
                          "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
                      widget.onLocationSelected(fullAddress);
                    } else {
                      widget.onLocationSelected("Alamat tidak ditemukan!");
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Submit',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
