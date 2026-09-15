import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_dialogs.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:e_commerce_app/features/home/domain/entities/products_response_entity.dart';
import 'package:e_commerce_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsPage extends StatefulWidget {
  final HomeCubit homeCubit;
  final ProductsResponseEntity product;
  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.homeCubit,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late final PageController pageController;
  late bool isFavorite;
  late CartItemModel? productInCart;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    isFavorite = false;
    productInCart = null;
    _loadLocalProductState();
  }

  Future<void> _loadLocalProductState() async {
    final savedProduct = await widget.homeCubit.getSavedProduct(
      widget.product.id,
    );
    final cartProduct = await widget.homeCubit.getProductFromCart(
      widget.product.id,
    );
    if (!mounted) return;
    setState(() {
      isFavorite = savedProduct?.isFavorite ?? false;
      productInCart = cartProduct;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<HomeCubit, HomeState>(
        bloc: widget.homeCubit,
        listenWhen: (previous, current) =>
            current is AddingProductToCart ||
            current is ProductAddedToCart ||
            current is ProductAddToCartError,
        listener: (context, state) {
          if (state is AddingProductToCart) {
            AppDialogs.showLoadingDialog(context, title: 'Adding to Cart...');
          }
          if (state is ProductAddedToCart) {
            Navigator.of(context).pop(); // Close the loading dialog
            AppDialogs.showSnackBar(
              context: context,
              message: 'Product added to cart successfully!',
            );
          }
          if (state is ProductAddToCartError) {
            Navigator.of(context).pop(); // Close the loading dialog
            AppDialogs.showSnackBar(
              context: context,
              message: 'Failed to add product to cart: ${state.message}',
              isError: true,
            );
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.background,
              pinned: true,
              leading: Padding(
                padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 8.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black.withAlpha(60),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      size: 28.sp,
                      Icons.arrow_back_rounded,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              actions: [
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () async {
                    isFavorite
                        ? await widget.homeCubit.deleteProduct(
                            widget.product.id,
                          )
                        : await widget.homeCubit.saveProduct(
                            ProductModel(
                              id: widget.product.id,
                              images: widget.product.images,
                              title: widget.product.title,
                              description: widget.product.description,
                              price: widget.product.price,
                              isFavorite: !isFavorite,
                            ),
                          );
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: AppColors.black.withAlpha(60),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.white,
                      size: 28.sp,
                    ),
                  ),
                ),
              ],
              actionsPadding: EdgeInsets.only(right: 16.w),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: size.height * 0.41,
                    child: Builder(
                      builder: (context) {
                        final displayImages = widget.product.images.isNotEmpty
                            ? widget.product.images
                            : const ['https://picsum.photos/800'];
                        return PageView.builder(
                          controller: pageController,
                          onPageChanged: (value) {
                            setState(() {});
                          },
                          itemCount: displayImages.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(16.r),
                              child: CachedNetworkImage(
                                imageUrl: displayImages[index],
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                    baseColor: AppColors.gray.withAlpha(150),
                                    highlightColor: AppColors.gray.withAlpha(50),
                                    child: Container(
                                      width: size.width * 0.5,
                                      height: size.width * 0.4,
                                      color: AppColors.gray,
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) => Container(
                                  width: size.width * 0.5,
                                  height: size.width * 0.4,
                                  color: AppColors.gray.withAlpha(50),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: AppColors.gray,
                                    size: 36.sp,
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.center,
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: widget.product.images.isNotEmpty
                          ? widget.product.images.length
                          : 1,
                      axisDirection: Axis.horizontal,
                      effect: WormEffect(
                        dotWidth: 10.w,
                        dotHeight: 10.h,
                        dotColor: const Color(0xffAFAFAF),
                        activeDotColor: const Color(0xff212121),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.title,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        'EGP ${widget.product.price}',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 36.h),
                  Text(
                    widget.product.description,
                    maxLines: 8,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: AppColors.primary.withAlpha(150),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 36.h),
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: widget.homeCubit,
                    buildWhen: (previous, current) =>
                        current is ProductAddedToCart,
                    builder: (context, state) {
                      return productInCart != null
                          ? MainButton(onPressed: null, text: 'Already in Cart')
                          : MainButton(
                              onPressed: () async {
                                final cartProduct = CartItemModel(
                                  id: widget.product.id,
                                  images: widget.product.images,
                                  title: widget.product.title,
                                  price: widget.product.price,
                                );
                                await widget.homeCubit.addProductToCart(
                                  cartProduct,
                                );
                                if (!mounted) return;
                                setState(() {
                                  productInCart = cartProduct;
                                });
                              },
                              text: 'Add to Cart',
                            );
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
