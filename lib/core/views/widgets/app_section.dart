import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/features/account/presentation/view/pages/account_page.dart';
import 'package:e_commerce_app/features/cart/presentation/view/pages/cart_page.dart';
import 'package:e_commerce_app/features/favorite/presentation/view/pages/favorite_page.dart';
import 'package:e_commerce_app/features/home/presentation/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class TabItem {
  final IconData icon;
  final String label;

  TabItem({required this.label, required this.icon});
}

class _AppSectionState extends State<AppSection> {
  late final PageController pageController;
  int activeIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: activeIndex);
    pages = const [HomePage(), CartPage(), FavoritePage(), AccountPage()];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<TabItem> tabs = [
      TabItem(label: 'Home', icon: Icons.home),
      TabItem(label: 'Cart', icon: Icons.shopping_cart),
      TabItem(label: 'Favorite', icon: Icons.favorite),
      TabItem(label: 'Account', icon: Icons.account_circle),
    ];
    return Scaffold(
      body: pages[activeIndex],
      // body: PageView.builder(
      //   controller: pageController,
      //   itemCount: pages.length,
      //   onPageChanged: (index) => setState(() => activeIndex = index),
      //   physics:
      //       const NeverScrollableScrollPhysics(), // Disable swipe navigation
      //   itemBuilder: (context, index) => pages[index],
      // ),
      bottomNavigationBar: //Container(
          // decoration: BoxDecoration(
          //   border: Border(
          //     top: isLightMode
          //     ? BorderSide.none
          //     : BorderSide(
          //       color:AppColors.primary.withAlpha(200),
          //       width: 0.8.r,
          //     ),
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.primary,
                  width: 0.8.r,
                ),
              ),
            ),
            child: AnimatedBottomNavigationBar.builder(
              itemCount: tabs.length,
              activeIndex: activeIndex,
              onTap: (index) {
                activeIndex = index;
                setState(() {});
              },
              gapLocation: GapLocation.none,
              elevation: 10,
              backgroundColor: AppColors.background,
              tabBuilder: (index, isActive) {
                final color = isActive ? AppColors.black : AppColors.gray;
                return SizedBox.expand(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(tabs[index].icon, color: color, size: 24.sp),
                      SizedBox(height: 4.h),
                      Text(
                        tabs[index].label,
                        style: TextStyle(
                          color: color,
                          fontSize: 14.sp,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
    );
  }
}
