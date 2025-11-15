import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikespot/blocs/cubits/auth_cubit.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
// import 'package:hikespot/pages/payment/presentation/widgets/no_card_container.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/widgets/gesture_container.dart';
import 'package:uuid/uuid.dart';
import '../../../../utils/app_text_style.dart';
// import 'package:payfast/payfast.dart' as  pa;
// import 'package:payfast/src/models/merchant_details.dart';

@RoutePage()
class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).pop();
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                        color: AppColors.primaryDark.withOpacity(0.37),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back,
                        color: AppColors.whiteColor),
                  ),
                ),
                const AppTextStyle(
                    text: "Wallet",
                    fontSize: 20,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            BlocBuilder(
              bloc: authCubit,
              builder: (context, state) {
                return AppTextStyle(
                  text: "ZAR ${authCubit.authData.balance}",
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                );
              },
            ),
            const SizedBox(
              height: 36,
            ),
            GestureContainer(
              text: "Add Money",
              borderRadius: 100,
              isNeedArrow: false,
              onTap: () {
                AutoRouter.of(context).push(const AddMoneyPageRoute());
              },
              textColor: AppColors.blackColor,
            ),
            if (authCubit.authData.balance >= 20)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GestureContainer(
                  text: "Withdraw",
                  borderRadius: 100,
                  isNeedArrow: false,
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        elevation: 0,
                        contentPadding: EdgeInsets.all(0),
                        content: BankDetails(),
                      ),
                    );
                    // AutoRouter.of(context).push(const AddMoneyPageRoute());
                  },
                  textColor: AppColors.blackColor,
                ),
              ),
            const SizedBox(
              height: 34,
            ),
            // const Align(
            //   alignment: Alignment.topLeft,
            //   child: AppTextStyle(
            //     text: "Cards",
            //     fontSize: 20,
            //     fontWeight: FontWeight.w500,
            //     color: AppColors.primaryDark,
            //   ),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            // const NoCardContainer(),
            const SizedBox(
              height: 10,
            ),
            const AppTextStyle(
              text: "All payment information is stored securely",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ],
        ),
      )),
    );
  }
}

class BankDetails extends StatefulWidget {
  BankDetails({
    super.key,
  });

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  TextEditingController nameController = TextEditingController();

  TextEditingController ibanController = TextEditingController();

  TextEditingController swiftCodeController = TextEditingController();

  TextEditingController bankNameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  //  get the payment info of the user if already added

  @override
  void initState() {
    // getting info before building the popup

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mdWidth = MediaQuery.of(context).size.width;
    double mdHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //  field to show the already added data or change

            Column(
              children: [
                Icon(
                  Icons.error_outline,
                  size: mdWidth * .09,
                  color: Colors.black,
                ),
                SizedBox(
                  height: mdHeight * .01,
                ),
                Text(
                  'Enter your payout details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: mdWidth * .05,
                  ),
                ),
                SizedBox(
                  height: mdHeight * .02,
                ),
                PayFieldWidget(
                    maxLine: 1,
                    hint: 'Full Name*',
                    keyboardType: TextInputType.text,
                    controller: nameController),
                PayFieldWidget(
                    isAccountNum: true,
                    maxLine: 1,
                    hint: 'IBAN or Account Number*',
                    keyboardType: TextInputType.text,
                    controller: ibanController),
                PayFieldWidget(
                    isSwiftCOde: true,
                    maxLine: 1,
                    hint: 'SWIFT Code*',
                    keyboardType: TextInputType.text,
                    controller: swiftCodeController),
                PayFieldWidget(
                    hint: 'Bank Name*',
                    maxLine: 1,
                    keyboardType: TextInputType.text,
                    controller: bankNameController),
                PayFieldWidget(
                    hint: 'Bank Address*',
                    maxLine: 6,
                    keyboardType: TextInputType.text,
                    controller: addressController),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: Row(
                    children: [
                      //  function to update the data of the user bank info

                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        onPressed: () async {
                          if (nameController.text.isNotEmpty &&
                              ibanController.text.isNotEmpty &&
                              swiftCodeController.text.isNotEmpty &&
                              bankNameController.text.isNotEmpty &&
                              addressController.text.isNotEmpty) {
                            String withDrawID = const Uuid().v4();
                            await FirebaseFirestore.instance
                                .collection('withdraw_requests')
                                .doc(withDrawID)
                                .set({
                              'name': nameController.text,
                              'IBAN': ibanController.text,
                              'swiftCode': swiftCodeController.text,
                              'bankName': bankNameController.text,
                              'address': addressController.text,
                              'captainId': authCubit.authData.uid,
                              'withDrawId': withDrawID,
                              'withDrawAmount': authCubit.authData.balance,
                              'status': 'pending',
                              'time': DateTime.now(),
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Payemnt withdraw request submitted..')));
                            nameController.clear();
                            swiftCodeController.clear();
                            addressController.clear();
                            ibanController.clear();
                            bankNameController.clear();
                          } else {}
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Send Request',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PayFieldWidget extends StatelessWidget {
  PayFieldWidget(
      {super.key,
      required this.hint,
      required this.keyboardType,
      required this.controller,
      this.isSwiftCOde = false,
      this.isAccountNum = false,
      required this.maxLine});
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int maxLine;
  // final String khularegular = '';
  bool isSwiftCOde;
  bool isAccountNum;
  @override
  Widget build(BuildContext context) {
    double mdWidth = MediaQuery.of(context).size.width;
    double mdHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        margin: EdgeInsets.only(top: mdHeight * .02),
        height: maxLine == 6 ? mdHeight * .2 : mdHeight * .06,
        child: TextFormField(
          controller: controller,
          // inputFormatters: [
          //   isSwiftCOde
          //       ? LengthLimitingTextInputFormatter(9)
          //       : isAccountNum
          //           ? LengthLimitingTextInputFormatter(10000)
          //           : LengthLimitingTextInputFormatter(60)
          // ],
          keyboardType: keyboardType,
          maxLines: maxLine,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                top: mdHeight * .01, left: mdWidth * .03, right: mdWidth * .03),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: mdWidth * .005, color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: mdWidth * .005, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: mdWidth * .005, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}

final AuthCubit authCubit = Di().sl<AuthCubit>();
