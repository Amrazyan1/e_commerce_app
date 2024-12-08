import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../models/delivery_addreses_model.dart';
import '../../../services/api_service.dart';

@RoutePage()
class DeliveryAddresseScreen extends StatefulWidget {
  const DeliveryAddresseScreen({super.key});

  @override
  State<DeliveryAddresseScreen> createState() => _DeliveryAddresseScreenState();
}

class _DeliveryAddresseScreenState extends State<DeliveryAddresseScreen> {
  final ApiService _apiService = GetIt.I<ApiService>();
  List<Map<String, dynamic>> addresses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    try {
      final DeliveryAddressesResponse response =
          await _apiService.getUserAddresses(1);
      final List<Map<String, dynamic>> fetchedAddresses = (response.data ?? [])
          .map((e) => {
                'id': e.id,
                'address': e.address,
                'info': e.details,
                'selected': e.isDefault ?? false,
              })
          .toList();

      setState(() {
        addresses = fetchedAddresses;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log('Failed to load addresses: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load addresses: $e')),
      );
    }
  }

  void _selectAddress(int index) {
    setState(() {
      for (int i = 0; i < addresses.length; i++) {
        if (i == index) {
          log(addresses[i]['id'].toString());
          _apiService.setDefaultAddress(addresses[i]['id'].toString());
        }
        addresses[i]['selected'] = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'delivery_address'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: ButtonMainWidget(
            text: 'add_new_address'.tr(),
            callback: () {
              AutoRouter.of(context).push(DeliveryAddressNew());
            },
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : addresses.isEmpty
              ? Center(child: Text("no_address_found".tr()))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(defaultPadding),
                        itemCount: addresses.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          final bool isSelected = address['selected'] as bool;

                          return Dismissible(
                            key: Key(address['id']
                                .toString()), // Ensure each item has a unique key
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                addresses.removeAt(index);
                              });
                              _apiService
                                  .deleteAddressById(address['id'].toString());
                              // Optionally, show a snackbar or some feedback
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Address removed")),
                              );
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () => _selectAddress(index),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          address['address']!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          address['info']!,
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(
                                    isSelected
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: isSelected
                                        ? ksecondaryColor
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
