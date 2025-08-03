import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_bloc.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_event.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import '../../../services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mapToolkit;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

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
    zoom: 15,
  );
  bool loading = false;

  LatLng? _selectedLocation;
  String? _regionId;
  String _address = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    // mapController.animateCamera(
    //   CameraUpdate.newLatLng(
    //     LatLng(yerevanCenter.latitude!, yerevanCenter.longitude!),
    //   ),
    // );
    // _onMapTap(LatLng(yerevanCenter.latitude!, yerevanCenter.longitude!));
    // return;
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

  double get circleRadius => 8000;

  bool isMarkerInsideCircle(
      mapToolkit.LatLng markerPosition, mapToolkit.LatLng circleCenter, double circleRadius) {
    num distanceBetween =
        mapToolkit.SphericalUtil.computeDistanceBetween(circleCenter, markerPosition);
    return distanceBetween <= circleRadius;
  }

  bool isInsede = false;
  mapToolkit.LatLng yerevanCenter = mapToolkit.LatLng(40.18206417925203, 44.51468563638671);

  void _onMapTap(LatLng position) async {
    isInsede = isMarkerInsideCircle(
        mapToolkit.LatLng(position.latitude, position.longitude), yerevanCenter, circleRadius);
    setState(() {
      isInsede = isInsede;
    });
    if (!isInsede) {
      return;
    }
    setState(() {
      _selectedLocation = position;
    });

    try {
      final reverseGeocodeResponse =
          await widget.apiService.reverseGeocode(position.latitude, position.longitude);

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
    getPolyPoints();
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
    if (context.read<SettingsBloc>().settingsmodel == null) {
      context.read<SettingsBloc>().add(FetchUserSettingsEvent());

      // Wait until the settingsmodel is fetched
      while (context.read<SettingsBloc>().settingsmodel == null) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
    final lat = context.read<SettingsBloc>().settingsmodel!.data!.storeAddress!.lat;
    final long = context.read<SettingsBloc>().settingsmodel!.data!.storeAddress!.long;
    int distanceInMeters = await getPolyPoints();
    // Geolocator.distanceBetween(
    //   double.parse(lat!),
    //   double.parse(long!),
    //   _selectedLocation!.latitude,
    //   _selectedLocation!.longitude,
    // );
    log('$distanceInMeters');

    try {
      final addressDetails = {
        'name': _nameController.text,
        'address': _nameController.text,
        'details': _addressController.text,
        'latitude': _selectedLocation!.latitude,
        'longitude': _selectedLocation!.longitude,
        'distance': (distanceInMeters / 1000).toStringAsFixed(2),
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

  Future<int> getPolyPoints() async {
    final lat = context.read<SettingsBloc>().settingsmodel!.data!.storeAddress!.lat;
    final long = context.read<SettingsBloc>().settingsmodel!.data!.storeAddress!.long;
    PolylinePoints polylinePoints = PolylinePoints();

    log('$lat  $long');
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: 'AIzaSyAYXgkuGsBPlVLThEP4crxBFZYarrRlDxg',
      request: PolylineRequest(
        origin: PointLatLng(
          double.parse(lat!),
          double.parse(long!),
        ),
        destination: PointLatLng(
          _selectedLocation!.latitude,
          _selectedLocation!.longitude,
        ),
        mode: TravelMode.driving,
      ),
    );
    log('NEWQ DISTANCEEE ${result.totalDistanceValue}');

    return result.totalDistanceValue ?? 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("delivery_address".tr()),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SizedBox(
          height: 50,
          child: ButtonMainWidget(
              callback: isInsede ? _addNewAddress : null,
              text: isInsede ? 'add_address'.tr() : 'out_bounds'.tr(),
              customwidget: loading ? const CircularProgressIndicator(color: Colors.white) : null),
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
                    cloudMapId: Platform.isAndroid ? "75c80c69218fa3d7" : "f886856e2413792",
                    initialCameraPosition: _initialPosition,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                    circles: {
                      Circle(
                          circleId: CircleId('1'),
                          center: LatLng(yerevanCenter.latitude, yerevanCenter.longitude),
                          radius: circleRadius,
                          strokeWidth: 2,
                          strokeColor: Colors.red.withOpacity(0.2))
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
                    myLocationEnabled: false,
                    zoomControlsEnabled: false,
                  ),
                  Positioned(
                    bottom: 16, // Position slightly above the bottom of the map
                    right: 16, // Position slightly from the right edge
                    child: FloatingActionButton(
                      backgroundColor: kprimaryColor,
                      onPressed: getCurrentLocation, // Centers map on current location
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
                  _address = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: "delivery_address".tr(),
                  border: const OutlineInputBorder(),
                ),
                minLines: 1, // Minimum height
                maxLines: null, // Makes the height dynamic based on content
                keyboardType: TextInputType.multiline, // Allows multiline input
                onChanged: (value) {
                  _address = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
