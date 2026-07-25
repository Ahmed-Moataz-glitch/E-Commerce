import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //! image onboarding
              SizedBox(
                height: 250.h,
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  itemBuilder: (context, index) => CustomAnimatedWidget(
                    delay: index,
                    index: index,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        onboardingList[index].imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  itemCount: onboardingList.length,
                ),
              ),
              SizedBox(height: 35),
              //! indicator onboarding
              SmoothPageIndicator(
                controller: controller,
                count: onboardingList.length,
                axisDirection: Axis.horizontal,
                effect: ExpandingDotsEffect(
                  dotWidth: 10.w,
                  dotHeight: 10.h,
                  dotColor: Color(0xffAFAFAF),
                  activeDotColor: Color(0xff212121),
                ),
              ),
              //! title onboarding and description onboarding
              SizedBox(height: 50.h),
              CustomAnimatedWidget(
                delay: (index + 1) * 100,
                index: index,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.w),
                  width: size.width,
                  child: Column(
                    children: [
                      Text(
                        onboardingList[index].title,
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff24252C),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        onboardingList[index].description,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6E6A7C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100.h),
              //! button next onboarding
              MainButton(
                onPressed: () {
                  if (index < onboardingList.length - 1) {
                    controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  } else {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.hello);
                  }
                },
                text: index < onboardingList.length - 1 ? "Next" : "Get Started",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// data class
class OnboardingData {
  final String title;
  final String description;
  final String image;
  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}

// data onboarding
class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

List<OnboardingModel> onboardingList = [
  OnboardingModel(
    title: 'Discover Trends',
    description: 'Now we are here to provide\nvariety of the best fashion',
    imagePath: AppAssets.onboardingImage1,
  ),
  OnboardingModel(
    title: 'Latest out fit',
    description: 'Express your self through the art of the fashionism',
    imagePath: AppAssets.onboardingImage2,
  ),
];

class CustomAnimatedWidget extends StatelessWidget {
  const CustomAnimatedWidget({
    super.key,
    required this.index,
    required this.delay,
    required this.child,
  });
  final int index;
  final int delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }
}
