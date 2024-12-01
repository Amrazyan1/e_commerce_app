import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/api_service.dart';
import '../../Products/Components/cart_button.dart';

@RoutePage()
class DeliveryAddressNew extends StatefulWidget {
  final ApiService apiService = GetIt.I<ApiService>();

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
  bool loading = false;

  LatLng? _selectedLocation;
  List<Map<String, String>> _addressItems = [];
  String? _regionId; // Example: Can be updated dynamically based on the region.

  void _onMapTap(LatLng position) async {
    setState(() {
      _selectedLocation = position;
      _addressItems = []; // Clear previous address items
    });

    try {
      final reverseGeocodeResponse = await widget.apiService
          .reverseGeocode(position.latitude, position.longitude);

      // Extract individual fields from the address
      final address = reverseGeocodeResponse.address;
      setState(() {
        _addressItems = [
          if (address?.houseNumber != null)
            {'label': 'House Number', 'value': address!.houseNumber!},
          if (address?.road != null) {'label': 'Road', 'value': address!.road!},
          if (address?.city != null) {'label': 'City', 'value': address!.city!},
          if (address?.postcode != null)
            {'label': 'Postcode', 'value': address!.postcode!},
          if (address?.country != null)
            {'label': 'Country', 'value': address!.country!},
        ];
      });
    } catch (e) {
      setState(() {
        _addressItems = [
          {'label': 'Error', 'value': 'Failed to fetch address: $e'},
        ];
      });
    }
  }

  void _addNewAddress() async {
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a location on the map.")),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      // Construct the address details
      final addressDetails = {
        'name': _addressItems.first['value'],
        'address': _addressItems
            .map((item) => item['value'])
            .join(', '), // Combine all address items
        'details': 'details',
        // 'latitude': _selectedLocation!.latitude.toString(),
        // 'longitude': _selectedLocation!.longitude.toString(),
      };

      // Send the data to the backend
      final response = await widget.apiService.addAddress(addressDetails);
      AutoRouter.of(context).maybePop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add address: $e")),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Address"),
      ),
      bottomNavigationBar: CartButton(
        press: _addNewAddress,
        infoWidget: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                'Add Address',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
      ),
      body: Column(
        children: [
          // Google Map
          SizedBox(
            height: 300,
            child: GoogleMap(
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
          ),

          // Address Info in ListTiles
          Expanded(
            child: _addressItems.isNotEmpty
                ? ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _addressItems.length,
                    itemBuilder: (context, index) {
                      final item = _addressItems[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(item['label']!),
                        subtitle: Text(item['value']!),
                      );
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Tap on the map to select a location",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
