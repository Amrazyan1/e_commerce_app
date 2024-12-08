import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import '../../../services/api_service.dart';
import '../../Products/Components/cart_button.dart';

@RoutePage()
class DeliveryAddressNew extends StatefulWidget {
  final ApiService apiService = GetIt.I<ApiService>();
  bool fromLogin;
  DeliveryAddressNew({super.key, this.fromLogin = false});

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
  String? _regionId; // Example: Can be updated dynamically based on the region.
  String _address = ""; // Store address as a single editable string
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    loc.Location location = loc.Location();
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    final userLocation = await location.getLocation();
    if (userLocation.latitude != null && userLocation.longitude != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(userLocation.latitude!, userLocation.longitude!),
        ),
      );
      _onMapTap(LatLng(userLocation.latitude!, userLocation.longitude!));
    }
  }

  void _onMapTap(LatLng position) async {
    setState(() {
      _selectedLocation = position;
    });

    try {
      final reverseGeocodeResponse = await widget.apiService
          .reverseGeocode(position.latitude, position.longitude);

      final address = reverseGeocodeResponse.address;
      setState(() {
        _nameController.text = address!.city ?? 'New address';
        _address = [
          if (address?.houseNumber != null) address!.houseNumber!,
          if (address?.road != null) address!.road!,
          if (address?.city != null) address!.city!,
          if (address?.postcode != null) address!.postcode!,
          if (address?.country != null) address!.country!,
        ].join(', ');
        _addressController.text = _address;
      });
    } catch (e) {
      setState(() {
        _address = "Failed to fetch address: $e";
        _addressController.text = _address;
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
      final addressDetails = {
        'name': _nameController.text,
        'address': _address,
        'details': _address,
      };

      final response = await widget.apiService.addAddress(addressDetails);
      if (widget.fromLogin) {
        AutoRouter.of(context).replaceAll([const EntryPoint()]);
      } else {
        AutoRouter.of(context).maybePop();
      }
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
        title: Text("delivery_address".tr()),
      ),
      bottomNavigationBar: CartButton(
        press: _addNewAddress,
        infoWidget: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                'add_address'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  GoogleMap(
                    mapToolbarEnabled: true,
                    compassEnabled: true,
                    myLocationButtonEnabled: true,
                    cloudMapId: Platform.isAndroid
                        ? "75c80c69218fa3d7"
                        : "f886856e2413792",
                    initialCameraPosition: _initialPosition,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                    onTap: _onMapTap,
                    markers: _selectedLocation != null
                        ? {
                            Marker(
                              markerId: const MarkerId('selected_location'),
                              position: _selectedLocation!,
                            ),
                          }
                        : {},
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                  ),
                  Positioned(
                    bottom: 16, // Position slightly above the bottom of the map
                    right: 16, // Position slightly from the right edge
                    child: FloatingActionButton(
                      backgroundColor: kprimaryColor,
                      onPressed:
                          getCurrentLocation, // Centers map on current location
                      child: const Icon(Icons.my_location, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "address_name".tr(),
                  border: const OutlineInputBorder(),
                ),
                minLines: 1, // Minimum height
                maxLines: null, // Makes the height dynamic based on content
                keyboardType: TextInputType.multiline, // Allows multiline input
                onChanged: (value) {
                  setState(() {
                    _address = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: "delivery_address".tr(),
                  border: OutlineInputBorder(),
                ),
                minLines: 1, // Minimum height
                maxLines: null, // Makes the height dynamic based on content
                keyboardType: TextInputType.multiline, // Allows multiline input
                onChanged: (value) {
                  setState(() {
                    _address = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
