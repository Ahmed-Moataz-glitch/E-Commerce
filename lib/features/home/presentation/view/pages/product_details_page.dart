import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/features/home/domain/entities/products_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductsResponseEntity product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late final PageController pageController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.background,
            pinned: true,
            leading: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(size: 32.sp, Icons.arrow_back_rounded),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(size: 32.sp, Icons.favorite_border),
              ),
            ],
            actionsPadding: EdgeInsets.only(right: 8.w),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: size.height * 0.41,
                  child: PageView.builder(
                    controller: pageController,
                    // physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {});
                    },
                    itemCount: widget.product.images.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(16.r),
                        child: CachedNetworkImage(
                          imageUrl: widget.product.images[index],
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
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: widget.product.images.length,
                    axisDirection: Axis.horizontal,
                    effect: WormEffect(
                      dotWidth: 10.w,
                      dotHeight: 10.h,
                      dotColor: Color(0xffAFAFAF),
                      activeDotColor: Color(0xff212121),
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
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 36.h),
                MainButton(onPressed: () {}, text: 'Add to Cart'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
