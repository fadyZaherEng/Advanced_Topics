// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api
import 'dart:math' as math;
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';

class VisaCardScreen extends StatefulWidget {
  @override
  _VisaCardScreenState createState() => _VisaCardScreenState();
}

class _VisaCardScreenState extends State<VisaCardScreen> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  late FocusNode _focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Awesome Card"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            CreditCard(
              cardNumber: cardNumber,
              cardExpiry: expiryDate,
              cardHolderName: cardHolderName,
              cvv: cvv,
              bankName: 'Axis Bank',
              showBackSide: showBack,
              frontBackground: CardBackgrounds.black,
              backBackground: CardBackgrounds.white,
              showShadow: true,
              // mask: getCardTypeMask(cardType: CardType.americanExpress),
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    controller: cardNumberCtrl,
                    decoration: const InputDecoration(hintText: 'Card Number'),
                    maxLength: 16,
                    onChanged: (value) {
                      final newCardNumber = value.trim();
                      var newStr = '';
                      const step = 4;

                      for (var i = 0; i < newCardNumber.length; i += step) {
                        newStr += newCardNumber.substring(
                            i, math.min(i + step, newCardNumber.length));
                        if (i + step < newCardNumber.length) newStr += ' ';
                      }

                      setState(() {
                        cardNumber = newStr;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    controller: expiryFieldCtrl,
                    decoration: const InputDecoration(hintText: 'Card Expiry'),
                    maxLength: 5,
                    onChanged: (value) {
                      var newDateValue = value.trim();
                      final isPressingBackspace =
                          expiryDate.length > newDateValue.length;
                      final containsSlash = newDateValue.contains('/');

                      if (newDateValue.length >= 2 &&
                          !containsSlash &&
                          !isPressingBackspace) {
                        newDateValue = '${newDateValue.substring(0, 2)}/${newDateValue.substring(2)}';
                      }
                      setState(() {
                        expiryFieldCtrl.text = newDateValue;
                        expiryFieldCtrl.selection = TextSelection.fromPosition(
                            TextPosition(offset: newDateValue.length));
                        expiryDate = newDateValue;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'Card Holder Name'),
                    onChanged: (value) {
                      setState(() {
                        cardHolderName = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'CVV'),
                    maxLength: 3,
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                    focusNode: _focusNode,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
