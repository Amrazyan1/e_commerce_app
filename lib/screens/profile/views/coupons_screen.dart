import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../blocs/coupons/bloc/coupons_bloc.dart';
import '../../../components/checkout_modal.dart';

@RoutePage()
class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  void _showCouponModal(BuildContext context) {
    TextEditingController couponController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the modal to adjust when the keyboard appears
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Wrap(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'add_coupon'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: couponController,
                    decoration: InputDecoration(
                      labelText: 'enter_coupon'.tr(),
                      border: const OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(
                          r'[A-Z0-9]')), // Only allows uppercase letters and numbers
                    ],
                    textCapitalization: TextCapitalization.characters,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ButtonMainWidget(
                        text: 'add_coupon'.tr(),
                        callback: () {
                          String couponCode = couponController.text.trim();
                          if (couponCode.isNotEmpty) {
                            context
                                .read<CouponsBloc>()
                                .add(AddCouponEvent(promoCode: couponCode));
                            Navigator.of(context).pop(); // Close the modal
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('enter_valid'.tr())),
                            );
                          }
                        },
                      )),
                  const SizedBox(height: 8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CouponsBloc, CouponsState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is CouponsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message.toString())),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Coupons'.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: ButtonMainWidget(
              text: 'add_coupon'.tr(),
              callback: () {
                _showCouponModal(context);
              },
            ),
          ),
        ),
        body: BlocBuilder<CouponsBloc, CouponsState>(
          builder: (context, state) {
            if (state is CouponsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CouponsLoaded || state is CouponsError) {
              final coupons = (state as CouponsLoaded).coupons;
              if (coupons.isEmpty) {
                return Center(child: Text('empty_coupons'.tr()));
              }
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: ListView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // Disable inner scroll for ListView
                    shrinkWrap:
                        true, // Make ListView take only the necessary height
                    itemCount: coupons.length,
                    itemBuilder: (context, index) {
                      final coupon = coupons[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10), // Add spacing between items
                        child: CouponCard(
                          height: 150,
                          backgroundColor: ksecondaryColor,
                          curveAxis: Axis.vertical,
                          curvePosition: 125,
                          borderRadius: 20,
                          firstChild: Container(
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            color: kprimaryColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        coupon.expiresIn ??
                                            'sf', // Assuming the coupon has a 'title' field
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            overflow: TextOverflow.ellipsis),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  coupon.discount ??
                                      '', // Assuming the coupon has a 'description' field
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          secondChild: Container(
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coupon.name ??
                                      '', // Assuming the coupon has an 'expirationDate' field
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Flexible(
                                  child: Text(
                                    "${coupon.description}", // Assuming the coupon has a 'discount' field
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
