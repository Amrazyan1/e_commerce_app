import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/Payment/payment_model.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:e_commerce_app/screens/Card/bloc/bloc/add_card_bloc_bloc.dart';
import 'package:e_commerce_app/services/api_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:u_credit_card/u_credit_card.dart';

@RoutePage()
class PaymentmethodsScreen extends StatelessWidget {
  const PaymentmethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddCardBlocBloc()..add(GetAllCards()),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'cards'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            body: BlocBuilder<AddCardBlocBloc, AddCardBlocState>(
              builder: (context, state) {
                if (state is AddCardLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is GetAllCardsState) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: // inside your Column children builder:
                            state.data.map((card) {
                          final idx = state.data.indexOf(card);
                          final parts = card.expiration.split('/');
                          final validMonth = parts.length == 2 ? parts[0] : '01';
                          final validYear = parts.length == 2 ? parts[1] : '26';
                          final validThru =
                              '$validMonth/${validYear.length == 4 ? validYear.substring(2) : validYear}';

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Dismissible(
                              key: ValueKey(card.uuid),
                              direction: DismissDirection.horizontal,
                              background: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.check_circle_outline, color: Colors.white),
                                    const SizedBox(width: 8),
                                    Text('set_primary'.tr(),
                                        style: const TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              secondaryBackground: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('delete'.tr(),
                                        style: const TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.w600)),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.delete_outline, color: Colors.white),
                                  ],
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  if (card.isDefault) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('already_prim'.tr())),
                                    );
                                    return false;
                                  }
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Make Primary'),
                                      content: Text('primary_info'.tr()),
                                      actions: [
                                        TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: Text('cancel'.tr())),
                                        TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: Text('confirm'.tr())),
                                      ],
                                    ),
                                  );
                                  if (confirmed == true) {
                                    ApiService apiService = GetIt.I<ApiService>();
                                    apiService.editCard(
                                        card.uuid, {'isDefault': true, 'name': card.cardholder});
                                  }
                                  return false;
                                } else {
                                  final res = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Card'),
                                      content: Text('delete_card_info'.tr()),
                                      actions: [
                                        TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: Text('cancel'.tr())),
                                        TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: Text('delete'.tr())),
                                      ],
                                    ),
                                  );
                                  return res ?? false;
                                }
                              },
                              onDismissed: (direction) {
                                ApiService apiService = GetIt.I<ApiService>();
                                if (direction == DismissDirection.startToEnd) {
                                } else if (direction == DismissDirection.endToStart) {
                                  apiService.deleteCard(card.uuid);
                                }
                              },
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  CreditCardUi(
                                    showValidFrom: false,
                                    cardHolderFullName: card.cardholder,
                                    cardNumber: card.pan,
                                    validThru: validThru,
                                    topLeftColor: card.isDefault
                                        ? Colors.green
                                        : Colors.primaries[idx % Colors.primaries.length],
                                    doesSupportNfc: true,
                                    placeNfcIconAtTheEnd: true,
                                    cardType: CardType.credit,
                                    creditCardType: CreditCardType.none,
                                    showBalance: false,
                                    autoHideBalance: true,
                                    cvvNumber: '***',
                                    cardProviderLogo: Image.network(
                                      card.icon,
                                      height: 36,
                                      width: 60,
                                      errorBuilder: (_, __, ___) => const Icon(Icons.credit_card),
                                    ),
                                    cardProviderLogoPosition: CardProviderLogoPosition.right,
                                  ),

                                  // Primary badge
                                  if (card.isDefault)
                                    Positioned(
                                      left: 8,
                                      top: 8,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          'PRIMARY',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }

                return const Center(child: Text("No cards found"));
              },
            ),
            bottomNavigationBar: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SizedBox(
                  height: 55,
                  child: ButtonMainWidget(
                    text: 'add_new_payment_method'.tr(),
                    callback: () async {
                      final ApiService apiService = GetIt.I<ApiService>();
                      final response = await apiService.addCard();
                      final decoded = jsonDecode(response.data);
                      final paymentResponse = PaymentResponse.fromJson(decoded);

                      if (!paymentResponse.errors) {
                        final redirectUrl = paymentResponse.data?.redirectUrl;
                        AutoRouter.of(context).push(WebviewRoute(
                          link: redirectUrl!,
                          onUrlChanged: (url) {
                            log(' URL changed: $url ');
                            //FAKE CALLBACK
                          },
                        ));
                        log("Redirect user to: $redirectUrl");
                      } else {
                        log("Error: ${paymentResponse.message}");
                      }
                    },
                  ),
                ),
              ),
            )));
  }
}
