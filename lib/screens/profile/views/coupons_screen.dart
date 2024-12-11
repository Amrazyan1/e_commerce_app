import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
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
  void _showCouponPopup(BuildContext context) {
    TextEditingController couponController = TextEditingController();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('activate_coupon').tr(),
          message: Column(
            children: [
              CupertinoTextField(
                controller: couponController,
                placeholder: 'enter_coupon_code'.tr(),
                padding: EdgeInsets.all(16),
              ),
              SizedBox(height: 16),
              CupertinoButton.filled(
                child: Text('activate_coupon').tr(),
                onPressed: () {
                  String couponCode = couponController.text.trim();
                  if (couponCode.isNotEmpty) {
                    context.read<CouponsBloc>().add(AddCouponEvent(promoCode: couponCode));
                    Navigator.of(context).pop(); // Close the popup
                    // Handle coupon activation logic here
                    print('Activating coupon: $couponCode');
                  } else {
                    // Show error or handle empty input
                    print('Coupon code is empty');
                  }
                },
              ),
            ],
          ),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
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
              _showCouponPopup(context);
            },
          ),
        ),
      ),
      body: BlocBuilder<CouponsBloc, CouponsState>(
        builder: (context, state) {
          if (state is CouponsLoading) {
              return const Center(child: CircularProgressIndicator());
          }
          if (state is CouponsLoaded) {
            return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  CouponCard(
                    height: 200,
                    backgroundColor: Colors.orangeAccent,
                    curveAxis: Axis.vertical,
                    curvePosition: 125,
                    borderRadius: 20,
                    firstChild: Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      color: Colors.orange,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "SPECIAL OFFER",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Save 20% on your next purchase!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
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
                          const Text(
                            "Valid until 15/12/24",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "2000֏",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(15),
                  CouponCard(
                    height: 200,
                    backgroundColor: Color(0xFFcaf3f0),
                    curveAxis: Axis.vertical,
                    curvePosition: 125,
                    borderRadius: 20,
                    firstChild: Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      color: Color(0xFF368f8b),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "SPECIAL OFFER",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Save 20% on your next purchase!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
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
                          const Text(
                            "Valid until 15/12/24",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "2000֏",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          
          }
          return Container();
        },
      ),
    );
  }
}
