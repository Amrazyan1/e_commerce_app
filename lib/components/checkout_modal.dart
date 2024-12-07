import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_app/blocs/categories/bloc/categories_bloc.dart';
import 'package:e_commerce_app/components/expansion_category.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/screens/order_accepted_screen.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../models/vieworderresponse_model.dart';

class CheckoutModal extends StatefulWidget {
  final ViewOrderData data;
  const CheckoutModal({super.key, required this.data});

  @override
  State<CheckoutModal> createState() => _CheckoutModalState();
}

class _CheckoutModalState extends State<CheckoutModal> {
  final ApiService _apiService = GetIt.I<ApiService>();
  String payType = 'cash';
  String address = 'address';

  List<CategoryModel> categories = [];
  @override
  void initState() {
    super.initState();
    if (widget.data.addresses != null) {
      categories.add(
        CategoryModel(
          title: "Delivery",
          info: "Select address",
          subCategories: (widget.data.addresses!)
              .map((address) => CategoryModel(
                  title: address.name ?? 'name',
                  info: address.details ?? 'details',
                  subCategories: [],
                  address: '${address.name},${address.details}',
                  isSelected: address.isDefault))
              .toList(),
        ),
      );
    }

    if (widget.data.paymentMethods != null) {
      categories.add(
        CategoryModel(
          title: "Payment",
          info: "Select Payment",
          subCategories: (widget.data.paymentMethods!)
              .map((payment) => CategoryModel(
                  title: payment.name ?? 'payment',
                  info: payment.name ?? 'payment',
                  paytipe: payment.slug,
                  subCategories: [],
                  isSelected: payment.slug == 'cash'))
              .toList(),
        ),
      );
    }
    categories.add(
      CategoryModel(
        title: "Total Cost",
        info: '${widget.data.total}',
        subCategories: [],
      ),
    );
  }

  void processOrder() async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      print(formattedDate);
      context.read<MainProvider>().isProcessOrder = true;
      final response = await _apiService.processOrder(widget.data.id!, {
        'address': address,
        'addressName': address,
        'additional': 'info',
        'date': formattedDate,
        'start': '${widget.data.start}',
        'end': '${widget.data.end}'
      });

      String responseId = jsonDecode(response.data)['data']['id'];
      final resp = await _apiService.payOrder(
        responseId,
        payType,
      );
      context.read<MainProvider>().isProcessOrder = false;
      context.read<CartBloc>().add(ClearCart());
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderAcceptedScreen(),
        ),
      );
    } catch (e) {
      log('order creation failed ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Checkout',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close))
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) => ExpansionCategory(
                    title: categories[index].title,
                    info: categories[index].info,
                    subCategory: categories[index].subCategories!,
                    onCategorySelected: (selectedCategory) {
                      if (selectedCategory.paytipe != null) {
                        payType = selectedCategory.paytipe!;
                      }
                      if (selectedCategory.address != null) {
                        address = selectedCategory.address!;
                      }
                      log("Selected category: ${selectedCategory.paytipe}, Info: ${selectedCategory.address}");
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                    height: 50,
                    child: ButtonMainWidget(
                      text: 'Place order',
                      customwidget:
                          context.watch<MainProvider>().isProcessOrder == true
                              ? const CircularProgressIndicator()
                              : null,
                      callback: processOrder,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonMainWidget extends StatelessWidget {
  ButtonMainWidget({
    super.key,
    required this.text,
    this.customwidget,
    this.callback,
  });
  final String text;
  Widget? customwidget;
  VoidCallback? callback;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kprimaryColor,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(defaultBorderRadius),
        ),
      ),
      child: InkWell(
        onTap: callback ?? () {},
        child: Center(
          child: customwidget ??
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
        ),
      ),
    );
  }
}

class _customListTile extends StatelessWidget {
  const _customListTile({
    super.key,
    required this.text,
    required this.text1,
  });

  final String text;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(
        text,
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text1,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset(
            "assets/icons/miniRight.svg",
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
