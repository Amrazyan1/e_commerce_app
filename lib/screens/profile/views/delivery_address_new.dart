import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/api_service.dart';

@RoutePage()
class DeliveryAddressNew extends StatefulWidget {
  final ApiService _apiService = GetIt.I<ApiService>();

  DeliveryAddressNew({super.key});

  @override
  State<DeliveryAddressNew> createState() => _DeliveryAddressNewState();
}

class _DeliveryAddressNewState extends State<DeliveryAddressNew> {
  late GoogleMapController mapController;
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(40.13558, 44.49223), // Default location
    zoom: 15.0,
  );

  LatLng? _selectedLocation;
  String? _address;

  void _onMapTap(LatLng position) async {
    setState(() {
      _selectedLocation = position;
      _address = null; // Clear previous address
    });

    // Fetch address from reverse geocoding API
    try {
      final data = await widget._apiService.reverseGeocode(
        position.latitude,
        position.longitude,
      );
      setState(() {
        _address = data['display_name'] ?? 'Address not found';
      });
    } catch (e) {
      setState(() {
        _address = 'Failed to fetch address: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Address"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            cloudMapId:
                Platform.isAndroid ? "97362ebb6d78549a" : "5f89739bf4061586",
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            onTap: _onMapTap, // Set tap handler to get location
            markers: _selectedLocation != null
                ? {
                    Marker(
                      markerId: const MarkerId('selected_location'),
                      position: _selectedLocation!,
                    ),
                  }
                : {},
            myLocationEnabled: true,
            zoomControlsEnabled: true,
          ),
          if (_address != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  _address!,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
