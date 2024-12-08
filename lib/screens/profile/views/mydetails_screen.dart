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
          // The Bottom margin is provided to align the popup above the system
          // navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      );
      // This block is executed when the date picker is dismissed.
      print('Date Picker closed. Selected Date: $picked');
      // Return the selected date (or null if the picker was dismissed without a selection).
      return picked;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoaded) {
                _dateTimeController.text = state.settings.data!.birthday ?? '';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildInputField(
                      controller: nameController,
                      label: 'Name',
                      defaultValue: '${state.settings.data!.fullName}',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      controller: emailController,
                      label: 'Email',
                      defaultValue: '${state.settings.data!.email}',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          CupertinoDatePicker(
                            initialDateTime: DateTime.now(),

                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: true,
                            // This shows day of week alongside day of month
                            showDayOfWeek: true,
                            // This is called when the user changes the date.
                            onDateTimeChanged: (DateTime newDate) {
                              log(newDate.toString());
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
                              onPressed: () {
                                // Handle calendar icon action
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      readOnly: true,
                      controller: phoneController,
                      label: 'Phone Number',
                      defaultValue: '${state.settings.data!.phone}',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                        height: 50,
                        child: ButtonMainWidget(
                          text: 'Save Details',
                          callback: () {
                            context.read<SettingsBloc>().add(SettingsUpdate(
                                name: nameController.text,
                                email: emailController.text,
                                birthdate: _dateTimeController.text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Details saved!')),
                            );
                          },
                        )),
                  ],
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
        TextField(
          readOnly: readOnly,
          controller: controller,
          keyboardType: keyboardType,
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
        ),
      ],
    );
  }
}
