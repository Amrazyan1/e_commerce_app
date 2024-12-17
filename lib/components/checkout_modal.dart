import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/Provider/main_provider.dart';
import 'package:e_commerce_app/blocs/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_app/blocs/categories/bloc/categories_bloc.dart';
import 'package:e_commerce_app/components/expansion_category.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/process_order_response.dart';
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
  String addressid = 'address';
  String useBonus = '0';
  String couponId = '';

  List<CategoryModel> categories = [];
  @override
  void initState() {
    super.initState();

    if (widget.data.addresses != null) {
      categories.add(
        CategoryModel(
          title: "delivery".tr(),
          info: "sel_addr".tr(),
          subCategories: (widget.data.addresses!)
              .map((address) => CategoryModel(
                  title: address.name ?? 'name',
                  info: address.details ?? 'details',
                  subCategories: [],
                  address: '${address.id}',
                  isSelected: address.isDefault))
              .toList(),
        ),
      );
    }

    if (widget.data.paymentMethods != null) {
      categories.add(
        CategoryModel(
          title: "payment".tr(),
          info: "sel_payment".tr(),
          ignoreExpansion: true,
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
    if (widget.data.availableCoupons != null &&
        widget.data.availableCoupons!.isNotEmpty) {
      categories.add(
        CategoryModel(
          title: "coupon".tr(),
          info: "sel_coupon".tr(),
          subCategories: (widget.data.availableCoupons!)
              .map((coup) => CategoryModel(
                  title: coup.name ?? 'name',
                  info: coup.discount ?? 'details',
                  subCategories: [],
                  couponId: '${coup.id}',
                  isSelected: false))
              .toList(),
        ),
      );
    }

    widget.data.availableBonuses = '5500\$';
    if (widget.data.availableBonuses != null &&
        widget.data.availableBonuses!.isNotEmpty) {
      if (num.tryParse(widget.data.availableBonuses!) != 0) {
        categories.add(
          CategoryModel(
              title: "use_bonus".tr(),
              info: '${widget.data.availableBonuses}',
              subCategories: [],
              isCheckbox: true),
        );
      }
    }
  }

  String responseId = '';
  void processOrder() async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      context.read<MainProvider>().isProcessOrder = true;

      final dataObject = {
        'addressId': addressid,
        'additional': 'info',
        'date': formattedDate,
        'start': '${widget.data.start}',
        'end': '${widget.data.end}',
      };

      if (couponId != null && couponId.isNotEmpty) {
        dataObject['couponId'] = couponId;
      } else if (useBonus != null && useBonus.isNotEmpty) {
        dataObject['usingBonus'] = useBonus;
      }

      final response =
          await _apiService.processOrder(widget.data.id!, dataObject);
      final repsData = processOrderResponseFromJson(response.data);
      log(response.data);
      responseId = repsData.data!.id!;

      addOrUpdateCategory(
          categories, "price", 'price', '${repsData.data!.subtotal}');
      addOrUpdateCategory(categories, "delivery", 'delivery',
          '${repsData.data!.deliveryPrice}');
      addOrUpdateCategory(
          categories, "coupon", 'discount', '-${repsData.data!.discount}');
      addOrUpdateCategory(
          categories, "tot_cost", 'tot_cost', '${repsData.data!.total}');

      context.read<MainProvider>().isProcessOrder = false;
    } on DioException catch (e) {
      String errmsg = e.response?.data["message"].toString() ?? e.message!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errmsg)),
      );
    }
  }

  void payOrder() async {
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
  }

  void addOrUpdateCategory(
      List<CategoryModel> categories, String id, String title, String info) {
    final existingCategoryIndex = categories.indexWhere((cat) => cat.id == id);

    if (existingCategoryIndex != -1) {
      // Update the existing category
      categories[existingCategoryIndex] = CategoryModel(
        id: id,
        title: title.tr(),
        info: info,
        subCategories: [],
      );
    } else {
      // Add a new category
      categories.add(CategoryModel(
        id: id,
        title: title.tr(),
        info: info,
        subCategories: [],
      ));
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
                    Text(
                      'checkout'.tr(),
                      style: const TextStyle(
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
                    ignoreExpansion: categories[index].ignoreExpansion ?? false,
                    subCategory: categories[index].subCategories!,
                    isCheckbox: categories[index].isCheckbox,
                    onCategorySelected: (selectedCategory) {
                      if (selectedCategory.paytipe != null) {
                        payType = selectedCategory.paytipe!;
                      }
                      if (selectedCategory.isCheckbox) {
                        useBonus = selectedCategory.title;
                        log('$useBonus ${selectedCategory.title}');
                      }
                      if (selectedCategory.couponId.isNotEmpty) {
                        couponId = selectedCategory.couponId;
                        log('$couponId ${selectedCategory.info}');
                      }
                      if (selectedCategory.address != null) {
                        addressid = selectedCategory.address!;
                      }

                      processOrder();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                    height: 50,
                    child: ButtonMainWidget(
                      text: 'place_order'.tr(),
                      customwidget:
                          context.watch<MainProvider>().isProcessOrder == true
                              ? const CircularProgressIndicator()
                              : null,
                      callback: payOrder,
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
