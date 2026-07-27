import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_constants.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:shimmer/shimmer.dart';

class CartWidget extends StatefulWidget {
  final CartCubit cartCubit;
  const CartWidget({super.key, required this.cartCubit});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  bool isCartEmpty = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<CartCubit, CartState>(
      bloc: widget.cartCubit,
      buildWhen: (previous, current) => current is GetCartProducts,
      builder: (context, state) {
        if (state is GetCartProducts) {
          final cartProducts = state.cartProducts;
          isCartEmpty = cartProducts.isEmpty;
          return cartProducts.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: size.height * 0.15),
                  child: Column(
                    spacing: 24.h,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: size.width),
                      SvgPicture.asset(
                        AppAssets.emptyCartImage,
                        width: size.width * 0.5,
                        height: size.width * 0.5,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartProducts.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 48.h);
                      },
                      itemBuilder: (context, index) {
                        final product = cartProducts[index];
                        // int cartItemCount = 1;
                        return Row(
                          spacing: 12.w,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: CachedNetworkImage(
                                imageUrl: product.images.first,
                                width: size.width * 0.2,
                                height: size.height * 0.1,
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                    baseColor: AppColors.gray.withAlpha(150),
                                    highlightColor: AppColors.gray.withAlpha(
                                      50,
                                    ),
                                    child: Container(
                                      width: size.width * 0.3,
                                      height: size.height * 0.15,
                                      color: AppColors.gray,
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await widget.cartCubit
                                              .removeProductFromCart(
                                                product.id,
                                              );
                                          setState(() {
                                            widget.cartCubit.getCartProducts();
                                          });
                                        },
                                        child: Icon(Icons.close_rounded),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'EGP ${product.price * product.itemCount}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4.r),
                                        decoration: BoxDecoration(
                                          color: AppColors.gray.withAlpha(50),
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: Row(
                                          spacing: 12.w,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (product.itemCount > 1) {
                                                    product.itemCount--;
                                                  }
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                size: 24.sp,
                                              ),
                                            ),
                                            Text(
                                              '${product.itemCount}',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (product.itemCount < 20) {
                                                    product.itemCount++;
                                                  }
                                                });
                                              },
                                              child: Icon(
                                                Icons.add,
                                                size: 24.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    isCartEmpty
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              SizedBox(height: size.height * 0.15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping fee',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'EGP ${AppConstants.shippingFee}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sub total',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'EGP ${widget.cartCubit.getSubtotalPrice(cartProducts: (widget.cartCubit.state as GetCartProducts).cartProducts)}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: AppColors.primary.withAlpha(150),
                                thickness: 1.r,
                                height: 32.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'EGP ${widget.cartCubit.getTotalPrice(cartProducts: (widget.cartCubit.state as GetCartProducts).cartProducts, shippingFee: int.parse(AppConstants.shippingFee))}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              MainButton(
                                text: 'Checkout',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentView(
                                        onPaymentSuccess: () async {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            AppRoutes.appSection,
                                            (route) => false,
                                          );
                                          await widget.cartCubit.clearCart();
                                        },
                                        onPaymentError: () {
                                          // Handle payment failure
                                        },
                                        price: widget.cartCubit
                                            .getTotalPrice(
                                              cartProducts:
                                                  (widget.cartCubit.state
                                                          as GetCartProducts)
                                                      .cartProducts,
                                              shippingFee: int.parse(
                                                AppConstants.shippingFee,
                                              ),
                                            )
                                            .toDouble(), // Required: Total price (e.g., 100 for 100 EGP)
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                  ],
                );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.emptyCartImage,
                width: size.width * 0.5,
                height: size.width * 0.5,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.h),
              Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          );
        }
      },
    );
  }
}
