import '../../lib.dart';

class AddressView extends BaseView<AddressController> {
  final String subTotal;
  const AddressView({
    super.key,
    required this.subTotal,
  });

  @override
  void initState(state) {
    super.initState(state);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.address = AppPreference.instance.getUserModel.address;
      controller.update();
    });
  }

  @override
  PreferredSizeWidget? get appBar => AppBarWidgets.defaultAppBar(
        title: "Address",
      );

  @override
  Widget? get body => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (controller.address.isNotEmpty)
                Column(
                  children: [
                    //*
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.address,
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),

                    //
                    SizedBox(height: 20.h),

                    //*
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),

                    //
                    SizedBox(height: 20.h),
                  ],
                ),
              Column(
                children: [
                  //
                  AppField.simple(
                    controller: controller.flatBuildingController,
                    hintText: 'Flat, House no, Building',
                  ),

                  //
                  SizedBox(height: 10.h),

                  //*
                  AppField.simple(
                    controller: controller.areaController,
                    hintText: 'Area, Street',
                  ),

                  //
                  SizedBox(height: 10.h),

                  //*
                  AppField.simple(
                    controller: controller.pincodeController,
                    hintText: 'Pincode',
                  ),

                  //
                  SizedBox(height: 10.h),

                  //*
                  AppField.simple(
                    controller: controller.cityController,
                    hintText: 'Town/City',
                  ),

                  //
                  SizedBox(height: 10.h),
                ],
              ),

              //*
              ApplePayButton(
                width: double.infinity,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(PaymentConfig.applePay),
                onPaymentResult: (res) => controller.onApplePayResult(
                  res,
                  subTotal,
                ),
                paymentItems: controller.paymentItems,
                margin: EdgeInsets.only(top: 15.h),
                height: 50.h,
                onPressed: () => controller.payPressed(
                  controller.address,
                  subTotal,
                ),
              ),

              //
              SizedBox(height: 10.h),

              //*
              GooglePayButton(
                onPressed: () => controller.payPressed(
                  controller.address,
                  subTotal,
                ),
                onPaymentResult: (res) => controller.onGooglePayResult(
                  res,
                  subTotal,
                ),
                paymentItems: controller.paymentItems,
                height: 50.h,
                type: GooglePayButtonType.buy,
                margin: EdgeInsets.only(top: 15.h),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(PaymentConfig.gpay),
              ),
            ],
          ),
        ),
      );
}
