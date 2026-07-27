import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_constants.dart';
import 'package:e_commerce_app/core/utils/get_it.dart';
import 'package:e_commerce_app/features/cart/presentation/view/widgets/cart_widget.dart';
import 'package:e_commerce_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartCubit cartCubit;

  @override
  void initState() {
    super.initState();
    cartCubit = getIt<CartCubit>();
    cartCubit.getCartProducts();
    PaymentData.initialize(
      apiKey: AppConstants
          .paymobApiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId:
          AppConstants.iframeId, // Required: Found under Developers -> iframes
      integrationCardId: AppConstants
          .integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId: AppConstants
          .integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
      // Optional User Data
      userData: UserData(
        email: "NA", // Optional: Defaults to 'NA'
        phone: "NA", // Optional: Defaults to 'NA'
        name: "NA", // Optional: Defaults to 'NA'
        lastName: "NA", // Optional: Defaults to 'NA'
      ),

      // Optional Style Customizations
      style: Style(
        primaryColor: AppColors.primary, // Default: Colors.blue
        scaffoldColor: AppColors.background, // Default: Colors.white
        appBarBackgroundColor: AppColors.primary, // Default: Colors.blue
        appBarForegroundColor: AppColors.white, // Default: Colors.white
        textStyle: TextStyle(), // Default: TextStyle()
        buttonStyle:
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.background,
            ), // Default: ElevatedButton.styleFrom()
        circleProgressColor: AppColors.primary, // Default: Colors.blue
        unselectedColor: AppColors.gray, // Default: Colors.grey
      ),
    );
  }

  @override
  void dispose() {
    cartCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CartWidget(cartCubit: cartCubit),
            ],
          ),
        ),
      ),
    );
  }
}
