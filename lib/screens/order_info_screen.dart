import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrderInfoScreen extends StatelessWidget {
  const OrderInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample product data
    final products = [
      {
        'name': 'Apple',
        'info': 'Fresh and crispy',
        'image': productDemoImg1,
        'count': 2,
        'price': '1200 AMD',
      },
      {
        'name': 'Orange',
        'info': 'Juicy and sweet',
        'image': productDemoImg1,
        'count': 3,
        'price': '1800 AMD',
      },
      {
        'name': 'Peach',
        'info': 'Soft and ripe',
        'image': productDemoImg1,
        'count': 1,
        'price': '800 AMD',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Order Info',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        itemCount: products.length + 1, // Products + summary info
        // separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          if (index < products.length) {
            final product = products[index];
            return SizedBox(
              height: 70,
              child: Row(
                children: [
                  Image.network(
                    product['image'].toString()!,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product['name'].toString()!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          product['info'].toString(),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'x${product['count']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        product['price'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            // After products, display summary information
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Delivery', '123 Main Street, City'),
                _buildInfoRow('Payment', 'Card **59'),
                _buildInfoRow('Promo Code', 'SUMMER2024'),
                _buildInfoRow('Total Cost', '7300 AMD'),
                _buildInfoRow('Status', 'Pending'),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
