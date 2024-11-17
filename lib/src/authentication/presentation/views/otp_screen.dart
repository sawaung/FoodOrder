import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_tdd/core/services/noti_service.dart';
import 'package:flutter_tdd/core/services/shared_pref.dart';
import 'package:flutter_tdd/core/util/constant.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/order_success_screen.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/widgets/add_user_phone.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key, required this.phoneNo,this.orderMeal});

  String phoneNo;
  Meal? orderMeal;
  bool invalidPin = false;
  bool clearText = false;

  @override
  State<OtpScreen> createState() {
    return _OtpScreenState();
  }
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    debugPrint("_log phoneNo ${widget.phoneNo}");
  }

    @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set your desired color here
        ),
        centerTitle: true,
        title: const Text(
          "Enter Pin",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("CURRENT PHONE NUMBER",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  TextButton(
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AddUserPhone(
                                changePhoneNo: true,
                                getPhoneNo: (phone) {
                                  setState(() {
                                    widget.phoneNo = phone;
                                  });
                                });
                          });
                    },
                    child: const Text("CHANGE"),
                  )
                ],
              ),
              Text(widget.phoneNo),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OtpTextField(
                    enabledBorderColor: Colors.black,
                    focusedBorderColor: Colors.red,
                    enabled: true,
                    numberOfFields: 6,
                    showFieldAsBox: false,
                    clearText: widget.clearText,
                    onCodeChanged: (value) {
                      setState(() {
                        widget.clearText = false;
                      });
                    },
                    onSubmit: (String verificationCode) async {
                      final code =
                          await Storage().getCode().then((value) => value);
                      if (verificationCode == code) {
                        if(context.mounted){
                          debugPrint("_log call order success ${widget.orderMeal}");
                          if(widget.orderMeal != null){
                            _callOrderSuccess(context,widget.orderMeal!);
                          }
                        }
                      } else {
                        setState(() {
                          widget.invalidPin = true;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              widget.invalidPin
                  ? Row(
                      children: [
                        const Text("Wrong OTP.",
                            style: TextStyle(color: Colors.red)),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                widget.clearText = true;
                                widget.invalidPin = false;
                              });
                            },
                            child: const Text(
                              "Try Again",
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    )
                  : const SizedBox.shrink(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Don\'t received?"),
                  TextButton(
                    onPressed: () {
                      final generateCode = generateRandomCode();
                      Storage().clearCode;
                      Storage().saveCode(generateCode);
                      NotificationService().showNotification(
                          title: 'OTP', body: 'your OTP is : $generateCode}');
                    },
                    child: const Text(
                      "Resend",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _callOrderSuccess(BuildContext context,Meal orderMeal){
    Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => OrderSuccessScreen(orderMeal: orderMeal)),
              (Route<dynamic> route) => false,
            );
  }
}
