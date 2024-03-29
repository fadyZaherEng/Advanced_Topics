// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class IntlPhoneWidget extends StatefulWidget {
  const IntlPhoneWidget({super.key});

  @override
  _IntlPhoneWidgetState createState() => _IntlPhoneWidgetState();
}

class _IntlPhoneWidgetState extends State<IntlPhoneWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Field Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              IntlPhoneField(
                focusNode: focusNode,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                languageCode: "en",
                controller: TextEditingController(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                initialCountryCode: 'US',
                showDropdownIcon: true,
                dropdownIconPosition: IconPosition.trailing,
                dropdownTextStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                dropdownIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  "1234567890".allMatches("1234567890").length == 10
                      ? FilteringTextInputFormatter.digitsOnly
                      : FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
                onCountryChanged: (country) {
                  print('Country changed to: ' + country.name);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  _formKey.currentState?.validate();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
