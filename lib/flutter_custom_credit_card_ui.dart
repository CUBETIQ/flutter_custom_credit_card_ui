// ---------------------------
// @Author: @lyhourchhen
// @Email: chhenlyhour@gmail.com
// @Date: 6/9/20 / 9:40 AM
// @Project: akara-app
// @Objective: Component to render CreditCard UI
// --------------------------

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCreditCard extends StatefulWidget {
  CustomCreditCard({
    @required this.cardNumber,
    @required this.cardHolder,
    @required this.month,
    @required this.year,
  });
  String cardNumber;
  String cardHolder;
  int month;
  int year;
  @override
  _CustomCreditCardState createState() => _CustomCreditCardState();
}

class _CustomCreditCardState extends State<CustomCreditCard> {
  int randomColor = 0;
  static final firstColor = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xffFFB775),
        Color(0xffD736FF),
      ]);
  static final secondColor = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xff98B4E9),
        Color(0xff9C1FFF),
      ]);
  final bgColor = <LinearGradient>[firstColor, secondColor];
  @override
  void initState() {
    var rng = new Random().nextInt(2);
    setState(() {
      randomColor = rng;
    });

    super.initState();
  }

  String renderCreditCardNumberUI(String creditCardNumber) {
    final value = creditCardNumber.replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)}  ");
    return value;
  }

  IconData renderCreditCardIconUI(String creditCardNumber) {
    var icons;
    var type = detectCCType(creditCardNumber);
    if (type == CreditCardType.visa) {
      return icons = FontAwesomeIcons.ccVisa;
    }
    if (type == CreditCardType.mastercard) {
      return icons = FontAwesomeIcons.ccMastercard;
    }
    if (type == CreditCardType.unknown) {
      return icons = FontAwesomeIcons.solidCreditCard;
    }
    return icons;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              gradient: bgColor[randomColor],
              borderRadius: BorderRadius.circular(15),
            ),
            height: 190,
            width: 343,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          child: Icon(
                        renderCreditCardIconUI(
                          widget.cardNumber == null
                              ? "1234123412346666"
                              : widget.cardNumber,
                        ),
                        size: 30,
                        color: Colors.white,
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 21),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          renderCreditCardNumberUI(
                            widget.cardNumber == null
                                ? "1234123412346666"
                                : widget.cardNumber,
                          ),
                          style: CreditNumber,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "CARD HOLDER",
                            style: headStyle,
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.cardHolder == null
                                ? "Jonh Doe"
                                : widget.cardHolder,
                            style: childStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Expiry Date",
                            style: headStyle,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${widget.month == null ? "00" : widget.month}/${widget.year == null ? "00" : widget.year}",
                            style: childStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
        Positioned(
          top: 0,
          left: 25,
          child: Container(
            child: Image.asset("assets/icons/creditCardStyleTop.png"),
            height: 53,
            width: 23,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 343 / 2,
          child: Container(
            child: Image.asset(
              "assets/icons/creditCardStyleBottom.png",
            ),
            height: 53,
            width: 23,
          ),
        ),
      ],
    );
  }
}

const CreditNumber = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontFamily: "Poppins",
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);
const headStyle = TextStyle(
  fontFamily: "Poppins",
  color: Colors.white70,
  fontSize: 10,
);
const childStyle = TextStyle(
  fontFamily: "Poppins",
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 10,
);
