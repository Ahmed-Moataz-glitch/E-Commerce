import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_constants.dart';
import 'package:e_commerce_app/core/utils/get_it.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartCubit cartCubit;
  bool isCartEmpty = false;

  @override
  void initState() {
    super.initState();
    cartCubit = getIt<CartCubit>();
    cartCubit.getCartProducts();
  }

  @override
  void dispose() {
    cartCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              BlocBuilder<CartCubit, CartState>(
                bloc: cartCubit,
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
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: product.images.first,
                                          width: size.width * 0.2,
                                          height: size.height * 0.1,
                                          placeholder: (context, url) {
                                            return Shimmer.fromColors(
                                              baseColor: AppColors.gray
                                                  .withAlpha(150),
                                              highlightColor: AppColors.gray
                                                  .withAlpha(50),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await cartCubit
                                                        .removeProductFromCart(
                                                          product.id,
                                                        );
                                                    setState(() {
                                                      cartCubit
                                                          .getCartProducts();
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 24.h),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                    color: AppColors.gray
                                                        .withAlpha(50),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12.r,
                                                        ),
                                                  ),
                                                  child: Row(
                                                    spacing: 12.w,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (product
                                                                    .itemCount >
                                                                1) {
                                                              product
                                                                  .itemCount--;
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
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (product
                                                                    .itemCount <
                                                                20) {
                                                              product
                                                                  .itemCount++;
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
                                        SizedBox(height: size.height * 0.25),
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
                                              'EGP ${cartCubit.getSubtotalPrice(cartProducts: (cartCubit.state as GetCartProducts).cartProducts)}',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: AppColors.primary.withAlpha(
                                            150,
                                          ),
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
                                              'EGP ${cartCubit.getTotalPrice(cartProducts: (cartCubit.state as GetCartProducts).cartProducts, shippingFee: int.parse(AppConstants.shippingFee))}',
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
                                          onPressed: () {},
                                        ),
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
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
