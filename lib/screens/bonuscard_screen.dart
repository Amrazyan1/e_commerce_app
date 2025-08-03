import 'package:auto_route/auto_route.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BonusCarScreen extends StatelessWidget {
  const BonusCarScreen({super.key, required this.code, required this.bonusPoints});
  final String code;
  final String bonusPoints;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'bonus_card'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the container
                  borderRadius: BorderRadius.circular(16), // Adjust as needed
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2), // Slight shadow for a better look
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16), // Padding inside the container
                child: Column(
                  children: [
                    BarcodeWidget(
                      data: code, // Replace with dynamic barcode data
                      barcode: Barcode.code128(),
                      width: double.infinity,
                      height: 120,
                      drawText: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'bonus_points'.tr(),
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        Text(
                          bonusPoints,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ],
                    ),
                    // Divider()
                  ],
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'Current month > ',
              //             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              //           ),
              //           Text(
              //             '32,600',
              //             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              //           ),
              //         ],
              //       ),
              //       Divider()
              //     ],
              //   ),
              // ),
              // const Gap(10),
              // Column(
              //   children: [
              //     SizedBox(
              //       height: 60,
              //       child: Row(
              //         children: [
              //           Expanded(child: ButtonMainWidget(text: 'Block')),
              //           Gap(10),
              //           Expanded(child: ButtonMainWidget(text: 'Delete')),
              //         ],
              //       ),
              //     ),
              //     Gap(10),
              //     SizedBox(height: 60, child: ButtonMainWidget(text: 'Reset pin')),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
