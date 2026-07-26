import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_toast.dart';
import 'package:e_commerce_app/core/utils/get_it.dart';
import 'package:e_commerce_app/features/home/presentation/view/widgets/product_item_widget.dart';
import 'package:e_commerce_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final HomeCubit homeCubit;
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    homeCubit = getIt<HomeCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeCubit.getCategories();
      homeCubit.getProducts();
    });
  }

  /// Recreate TabController when categories load with correct length
  void _initTabController(int length) {
    tabController?.dispose();
    tabController = TabController(length: length, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ── Greeting ──────────────────────────────────────────
              Text.rich(
                TextSpan(
                  text: 'Hi,\n',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: "let's start your day",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              /// ── Categories Tab Section ─────────────────────────────
              BlocConsumer<HomeCubit, HomeState>(
                bloc: homeCubit,

                /// Listen only for side-effects (toasts, navigation, etc.)
                listenWhen: (previous, current) =>
                    current is GetCategoriesError,

                /// Rebuild on loading + success + error
                buildWhen: (previous, current) =>
                    current is GetCategoriesLoading ||
                    current is GetCategoriesSuccess ||
                    current is GetCategoriesError,
                listener: (context, state) {
                  if (state is GetCategoriesError) {
                    AppToast.showToast(
                      context: context,
                      title: 'Error',
                      description: state.message,
                      type: ToastificationType.error,
                    );
                  }
                },
                builder: (context, state) {
                  /// ── Loading State ────────────────────────────────
                  if (state is GetCategoriesLoading) {
                    return _buildShimmerTabs();
                  }

                  /// ── Success State ────────────────────────────────
                  if (state is GetCategoriesSuccess) {
                    final categories = state.categories;

                    // Initialize controller with correct dynamic length
                    if (tabController == null ||
                        tabController!.length != categories.length) {
                      _initTabController(categories.length);
                    }

                    return Expanded(
                      child: Column(
                        children: [
                          /// Tab Buttons
                          ButtonsTabBar(
                            controller: tabController,
                            tabs: categories
                                .map((category) => Tab(text: category.name))
                                .toList(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                            ),
                            borderWidth: 1.2.r,
                            borderColor: AppColors.gray.withAlpha(200),
                            decoration: BoxDecoration(
                              color: AppColors.black.withAlpha(220),
                              border: Border.all(
                                color: AppColors.black,
                                width: 1.2.r,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            labelStyle: TextStyle(
                              color: AppColors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            unselectedDecoration: BoxDecoration(
                              color: AppColors.transparent,
                              border: Border.all(
                                color: AppColors.black,
                                width: 1.2.r,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            unselectedLabelStyle: TextStyle(
                              color: AppColors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            buttonMargin: EdgeInsets.only(right: 24.w),
                          ),
                          SizedBox(height: 36.h),

                          /// Tab Content
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: categories
                                  .map(
                                    (category) => Center(
                                      child: BlocConsumer<HomeCubit, HomeState>(
                                        bloc: homeCubit,
                                        listenWhen: (previous, current) =>
                                            current is GetProductsError,
                                        buildWhen: (previous, current) =>
                                            current is GetProductsLoading ||
                                            current is GetProductsSuccess,
                                        listener: (context, state) {
                                          if (state is GetProductsError) {
                                            AppToast.showToast(
                                              context: context,
                                              title: 'Error',
                                              description: state.message,
                                              type: ToastificationType.error,
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is GetProductsLoading) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (state is GetProductsSuccess) {
                                            final products = state.products
                                                .where(
                                                  (product) =>
                                                      product.category.name ==
                                                          category.name &&
                                                      product.images.first
                                                              .contains(
                                                                'placehold',
                                                              ) ==
                                                          false,
                                                )
                                                .toList();
                                            if(products.isEmpty) {
                                              return Center(
                                                child: Text(
                                                  'No products available',
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: AppColors.gray,
                                                  ),
                                                ),
                                              );
                                            }
                                            return GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 24.w,
                                                    // mainAxisSpacing: 12.h,
                                                    childAspectRatio: 0.7,
                                                  ),
                                              itemCount: products.length,
                                              itemBuilder: (context, index) {
                                                return ProductItemWidget(
                                                  homeCubit: homeCubit,
                                                  product: products[index],
                                                );
                                              },
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  /// ── Error / Initial State ────────────────────────
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ── Shimmer Skeleton for loading tabs ───────────────────────────────
  Widget _buildShimmerTabs() {
    return Shimmer.fromColors(
      baseColor: AppColors.gray.withAlpha(150),
      highlightColor: AppColors.gray.withAlpha(50),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            5, // Placeholder count
            (index) => Container(
              margin: EdgeInsets.only(right: 12.w),
              width: 80.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
