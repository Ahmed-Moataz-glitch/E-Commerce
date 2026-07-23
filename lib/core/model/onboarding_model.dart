import 'package:e_commerce_app/core/utils/app_assets.dart';

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
    description: 'Express your self through\nthe art of the fashionism',
    imagePath: AppAssets.onboardingImage2,
  ),
];