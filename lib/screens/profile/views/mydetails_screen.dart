import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/settings/bloc/settings_event.dart';
import 'package:e_commerce_app/components/checkout_modal.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/settings/bloc/settings_bloc.dart';
import '../../../blocs/settings/bloc/settings_state.dart';

@RoutePage()
class MyDetailsScreen extends StatelessWidget {
  const MyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController nameController = TextEditingController(),
        emailController = TextEditingController(),
        phoneController = TextEditingController();
    final TextEditingController _dateTimeController = TextEditingController();

    Future<DateTime?> showDialog(Widget child) async {
      DateTime? picked = await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      );
      return picked;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'my_details'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoaded) {
                _dateTimeController.text = state.settings.data!.birthday ?? '';
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildInputField(
                        controller: nameController,
                        label: 'name'.tr(),
                        defaultValue: '${state.settings.data!.fullName}',
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildInputField(
                        controller: emailController,
                        label: 'Email'.tr(),
                        defaultValue: '${state.settings.data!.email}',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              maximumDate: DateTime.now(),
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              showDayOfWeek: true,
                              onDateTimeChanged: (DateTime newDate) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(newDate);
                                _dateTimeController.text = formattedDate;
                              },
                            ),
                          );
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _dateTimeController,
                            readOnly: true,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Birth date'.tr(),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_month),
                                onPressed: () {},
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Birth date is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInputField(
                        readOnly: true,
                        controller: phoneController,
                        label: 'Phone Number'.tr(),
                        defaultValue: '${state.settings.data!.phone}',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 50,
                        child: ButtonMainWidget(
                          text: 'save_details'.tr(),
                          callback: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<SettingsBloc>().add(SettingsUpdate(
                                  name: nameController.text,
                                  email: emailController.text,
                                  birthdate: _dateTimeController.text));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Details saved!')),
                              );
                              AutoRouter.of(context).maybePop();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String defaultValue,
    required TextInputType keyboardType,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    if (controller.text.isEmpty) {
      controller.text = defaultValue;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: !readOnly,
          style: const TextStyle(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: label,
            border: const UnderlineInputBorder(),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 10,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
