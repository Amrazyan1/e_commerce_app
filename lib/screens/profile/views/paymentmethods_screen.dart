import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/Products/Components/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:u_credit_card/u_credit_card.dart';

@RoutePage()
class PaymentmethodsScreen extends StatelessWidget {
  const PaymentmethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Payment',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CreditCardUi(
                    width: 300,
                    cardHolderFullName: 'Arman Amrazyan',
                    cardNumber: '1234567812345678',
                    validFrom: '01/23',
                    validThru: '01/28',
                    topLeftColor: Colors.blue,
                    doesSupportNfc: true,
                    placeNfcIconAtTheEnd: true,
                    cardType: CardType.debit,
                    cardProviderLogoPosition: CardProviderLogoPosition.right,
                    showBalance: false,
                    autoHideBalance: true,
                    enableFlipping: false,
                    cvvNumber: '123',
                  ),
                  Gap(20),
                  CreditCardUi(
                    width: 300,
                    cardHolderFullName: 'Arman Amrazyan',
                    cardNumber: '1234567812345678',
                    validFrom: '01/23',
                    validThru: '01/28',
                    topLeftColor: Colors.purple,
                    doesSupportNfc: true,
                    placeNfcIconAtTheEnd: true,
                    cardType: CardType.debit,
                    cardProviderLogoPosition: CardProviderLogoPosition.right,
                    showBalance: false,
                    autoHideBalance: true,
                    enableFlipping: false,
                    cvvNumber: '123',
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
              height: 55,
              child: ButtonMainWidget(text: 'Add new payment method')),
        ));
  }
}
