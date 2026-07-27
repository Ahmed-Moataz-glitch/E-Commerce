import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/get_it.dart';
import 'package:e_commerce_app/features/favorite/presentation/view/widgets/favorite_item_widget.dart';
import 'package:e_commerce_app/features/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late final FavoriteCubit favoriteCubit;
  bool isFavoriteEmpty = true;

  @override
  void initState() {
    super.initState();
    favoriteCubit = getIt<FavoriteCubit>();
    favoriteCubit.getFavoriteProducts();
  }

  @override
  void dispose() {
    favoriteCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorite',
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
              BlocBuilder<FavoriteCubit, FavoriteState>(
                bloc: favoriteCubit,
                buildWhen: (previous, current) =>
                    current is GetFavoriteProducts,
                builder: (context, state) {
                  if (state is GetFavoriteProducts) {
                    final favoriteProducts = state.favoriteProducts;
                    isFavoriteEmpty = favoriteProducts.isEmpty;
                    return favoriteProducts.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: size.height * 0.15),
                            child: Column(
                              spacing: 24.h,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: size.width),
                                SvgPicture.asset(
                                  AppAssets.emptyFavoriteImage,
                                  width: size.width * 0.5,
                                  height: size.width * 0.5,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  'There are no products in your\n favorite list',
                                  textAlign: TextAlign.center,
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
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: favoriteProducts.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16.h,
                                      crossAxisSpacing: 24.w,
                                      childAspectRatio: 0.55,
                                    ),
                                itemBuilder: (context, index) {
                                  final favoriteProduct =
                                      favoriteProducts[index];
                                  // int cartItemCount = 1;
                                  return FavoriteItemWidget(
                                    favoriteCubit: favoriteCubit,
                                    favoriteProduct: favoriteProduct,
                                  );
                                },
                              ),
                            ],
                          );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.emptyFavoriteImage,
                          width: size.width * 0.5,
                          height: size.width * 0.5,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Your favorite list is empty',
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
