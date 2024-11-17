import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd/core/services/injection_container.dart';
import 'package:flutter_tdd/core/services/noti_service.dart';
import 'package:flutter_tdd/core/services/shared_pref.dart';
import 'package:flutter_tdd/core/util/constant.dart';
import 'package:flutter_tdd/src/authentication/domain/entities/meal.dart';
import 'package:flutter_tdd/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_tdd/src/authentication/presentation/views/otp_screen.dart';

class AddUserPhone extends StatelessWidget {
 AddUserPhone({super.key,required this.changePhoneNo,this.orderMeal,getPhoneNo});
  final bool changePhoneNo;
   Meal? orderMeal;
  void Function(String phoneNo) getPhoneNo = (phoneNo) {
    
  };

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<AuthenticationCubit>(),
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
          final cubit = context.read<AuthenticationCubit>();
          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            labelText: "Enter Phone Number"),
                            onChanged: (value) {
                        cubit.validatePhoneNumber(value.trim());
                      },
                      ),
                      
                      (state is PhoneNumberValidationState && !state.validatePhoneNumber) ? 
                      const Text("Invalid Phone Number(should start with 099 or 99 + [8]digit)", style: TextStyle(color: Colors.red)) :
                      const SizedBox(height: 5,),
                      
                      ElevatedButton(
                      onPressed: state is PhoneNumberValidationState && state.validatePhoneNumber
                          ? () {
                              final phoneNo = phoneController.text.trim();
                              phoneController.clear();
                              final generateCode = generateRandomCode();
                              Storage().saveCode(generateCode);
                              NotificationService().showNotification(title: 'OTP', body: 'your OTP is : $generateCode}');
                              Navigator.of(context).pop();
                              if(changePhoneNo){
                                getPhoneNo(phoneNo);
                              }
                              _callOtpScreen(context,phoneNo);
                              
                            }
                          : null, // Disabled when invalid
                      child: const Text('Continue'),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  void _callOtpScreen(BuildContext context,String phoneNo) {
    debugPrint("_log order pass to OTP screen $orderMeal");
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((ctx) => OtpScreen(
              phoneNo: phoneNo, orderMeal: orderMeal,
            ))));
  }

}
