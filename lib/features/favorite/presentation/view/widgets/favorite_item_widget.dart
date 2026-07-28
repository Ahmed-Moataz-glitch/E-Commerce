import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/features/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteItemWidget extends StatefulWidget {
  final FavoriteCubit favoriteCubit;
  final ProductModel favoriteProduct;
  const FavoriteItemWidget({
    super.key,
    required this.favoriteCubit,
    required this.favoriteProduct,
  });

  @override
  State<FavoriteItemWidget> createState() => _FavoriteItemWidgetState();
}

class _FavoriteItemWidgetState extends State<FavoriteItemWidget> {
  late CartItemModel? productInCart;

  @override
  void initState() {
    super.initState();
    productInCart = null;
    _loadCartState();
  }

  Future<void> _loadCartState() async {
    final cartProduct = await widget.favoriteCubit.getProductFromCart(
      widget.favoriteProduct.id,
    );
    if (!mounted) return;
    setState(() {
      productInCart = cartProduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: widget.favoriteProduct.images.first,
                width: size.width * 0.5,
                height: size.height * 0.22,
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: AppColors.gray.withAlpha(150),
                    highlightColor: AppColors.gray.withAlpha(50),
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
            Positioned(
              top: 8.h,
              right: 8.w,
              child: InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () async {
                  await widget.favoriteCubit.removeProductFromFavorites(
                    widget.favoriteProduct.id,
                  );
                  await widget.favoriteCubit.getFavoriteProducts();
                },
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: AppColors.black.withAlpha(100),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.white,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          widget.favoriteProduct.title,
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 4.h),
        Text(
          'EGP ${widget.favoriteProduct.price}',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 12.h),
        BlocBuilder<FavoriteCubit, FavoriteState>(
          bloc: widget.favoriteCubit,
          buildWhen: (previous, current) => current is ProductAddedToCart,
          builder: (context, state) {
            return productInCart != null
                ? MainButton(onPressed: null, text: 'Already in Cart')
                : MainButton(
                    onPressed: () async {
                      final cartProduct = CartItemModel(
                        id: widget.favoriteProduct.id,
                        images: widget.favoriteProduct.images,
                        title: widget.favoriteProduct.title,
                        price: widget.favoriteProduct.price,
                      );
                      await widget.favoriteCubit.addProductToCart(
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
      ],
    );
  }
}
