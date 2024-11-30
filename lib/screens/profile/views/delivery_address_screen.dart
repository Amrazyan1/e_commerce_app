import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
      final response = await _apiService.getUserAddresses(1);
      final List<Map<String, dynamic>> fetchedAddresses =
          (response.data as List)
              .map((e) => {
                    'id': e['id'],
                    'address': e['address'],
                    'info': e['details'],
                    'selected': e['isDefault'] ?? false,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load addresses: $e')),
      );
    }
  }

  void _selectAddress(int index) {
    setState(() {
      for (int i = 0; i < addresses.length; i++) {
        addresses[i]['selected'] = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Delivery Addresses',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : addresses.isEmpty
              ? const Center(child: Text("No addresses found."))
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

                          return GestureDetector(
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
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ButtonMainWidget(
                          text: 'Add new address',
                          callback: () {
                            AutoRouter.of(context).push(DeliveryAddressNew());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
