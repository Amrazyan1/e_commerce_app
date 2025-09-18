import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/Card/bloc/bloc/add_card_bloc_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../components/checkout_modal.dart';

@RoutePage()
class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  TextEditingController cardNumberController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  String? selectedOptionMonth = '01';
  String? selectedOptionYear = '2026';

  final List<String> months = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];
  final List<String> years = [
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031',
    '2032',
    '2033',
    '2034',
    '2035',
    '2036',
    '2037',
    '2038',
    '2039',
    '2040',
    '2041',
    '2042',
    '2043',
    '2044',
    '2045',
    '2046',
    '2047',
    '2048',
    '2049',
    '2050'
  ];

  final bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            toolbarHeight: 65.h,
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/arrow_back.svg",
                color: const Color.fromARGB(255, 255, 255, 255),
                height: 50.h,
              ),
              onPressed: (() {
                Navigator.pop(context);
              }),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
          )),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 100.h, left: 42.w, right: 40.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text('add_credit_card',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 37.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFFFFFF),
                        )).tr(),
                    SizedBox(
                      height: 19.h,
                    ),
                    Text('card_number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFFFFFFF),
                        )).tr(),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text('digits_nospace',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFD1DBFF),
                          )).tr(),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.w),
                      width: double.infinity,
                      height: 39.h,
                      decoration: BoxDecoration(
                          color: kInputsBgColor, borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                        child: TextField(
                          controller: cardNumberController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontSize: 14.sp),
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              border: InputBorder.none,
                              fillColor: kTextColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Text('your_name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFFFFFFF),
                        )).tr(),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text('as_stated',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFD1DBFF),
                          )).tr(),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.w),
                      width: double.infinity,
                      height: 39.h,
                      decoration: BoxDecoration(
                          color: kInputsBgColor, borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                        child: TextField(
                          controller: nameController,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontSize: 14.sp),
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              border: InputBorder.none,
                              fillColor: kTextColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Text('card_exp_date',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFFFFFFF),
                        )).tr(),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text('as_stated_date',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFD1DBFF),
                          )).tr(),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: 163.w,
                            height: 34.h,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedOptionMonth,
                                items: months.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedOptionMonth = value;
                                  });
                                },
                                hint: Text(
                                  '01',
                                  style: TextStyle(color: Colors.black.withOpacity(0.2)),
                                ),
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 133.w,
                            height: 34.h,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedOptionYear,
                                items: years.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedOptionYear = value;
                                  });
                                },
                                hint: Text(
                                  '2026',
                                  style: TextStyle(color: Colors.black.withOpacity(0.2)),
                                ),
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Text('cvv_text',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFFFFFFF),
                        )).tr(),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text('cvv_digit',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFD1DBFF),
                          )).tr(),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.w),
                      width: double.infinity,
                      height: 39.h,
                      decoration: BoxDecoration(
                          color: kInputsBgColor, borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                        child: TextField(
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontSize: 14.sp),
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              border: InputBorder.none,
                              fillColor: kTextColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       checkColor: kprimaryColor,
                    //       activeColor: Colors.white,
                    //       value: isChecked,
                    //       side: BorderSide(color: Colors.white),
                    //       onChanged: (bool? value) {
                    //         setState(() {
                    //           log('ssssssssssssssssssssssssssssss');
                    //           log(isChecked.toString());
                    //           isChecked = value!;
                    //         });
                    //       },
                    //     ),
                    //     Expanded(
                    //       child: RichText(
                    //         text: TextSpan(
                    //             text: 'I agree to the'.tr(),
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 10.sp,
                    //             ),
                    //             children: [
                    //               const TextSpan(text: ' '),
                    //               TextSpan(
                    //                   text: 'Terms of Service'.tr(),
                    //                   style: TextStyle(
                    //                       color: kButtonColor,
                    //                       fontSize: 10.sp,
                    //                       fontWeight: FontWeight.bold,
                    //                       decoration: TextDecoration.underline,
                    //                       decorationColor: Colors.white),
                    //                   recognizer: TapGestureRecognizer()..onTap = () {}),
                    //               const TextSpan(text: ' '),
                    //               TextSpan(
                    //                 text: 'and'.tr(),
                    //                 style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 10.sp,
                    //                     fontWeight: FontWeight.w400),
                    //               ),
                    //               const TextSpan(text: ' '),
                    //               TextSpan(
                    //                 text: 'Privacy Policy'.tr(),
                    //                 style: TextStyle(
                    //                     color: kButtonColor,
                    //                     fontSize: 10.sp,
                    //                     fontWeight: FontWeight.bold,
                    //                     decoration: TextDecoration.underline,
                    //                     decorationColor: Colors.white),
                    //                 recognizer: TapGestureRecognizer()..onTap = () {},
                    //               )
                    //             ]),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 25.h,
                    ),
                    ButtonMainWidget(
                        callback: () => {
                              context.read<AddCardBlocBloc>().add(AddCardEvent(
                                    cardHolder: nameController.text,
                                    cardNumber: cardNumberController.text,
                                    expiryDate: '$selectedOptionMonth/$selectedOptionYear',
                                    cvv: cvvController.text,
                                  )),
                            },
                        text: 'Save'.tr(),
                        customwidget: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : null),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'skip_for_now'.tr(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showDIalog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext buildcontext) {
  //         context.read<AuthProvider>().loadingContext = buildcontext;
  //         return WillPopScope(onWillPop: () async => false, child: const LoadingPanel());
  //       });
  // }
}
