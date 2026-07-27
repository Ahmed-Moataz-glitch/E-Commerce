import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:e_commerce_app/features/home/domain/entities/products_response_entity.dart';
import 'package:e_commerce_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductItemWidget extends StatefulWidget {
  final HomeCubit homeCubit;
  final ProductsResponseEntity product;
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.homeCubit,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.homeCubit.getSavedProduct(widget.product.id)?.isFavorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(12.r),
          child: Stack(
            children: [
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.productDetails,
                    arguments: {
                      'product': widget.product,
                      'homeCubit': widget.homeCubit,
                    },
                  ).then((_) {
                    setState(() {
                      isFavorite = widget.homeCubit.getSavedProduct(widget.product.id)?.isFavorite ?? false;
                    });
                  });
                },
                child: CachedNetworkImage(
                  imageUrl: widget.product.images.first,
                  width: size.width * 0.5,
                  height: size.width * 0.4,
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
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: InkWell(
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
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: AppColors.black.withAlpha(100),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.white,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          widget.product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4.h),
        Text(
          'EGP ${widget.product.price}',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
