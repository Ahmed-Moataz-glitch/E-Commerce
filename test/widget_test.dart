import 'package:e_commerce_app/core/views/widgets/main_button.dart';
import 'package:e_commerce_app/core/views/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MainButton and SecondaryButton smoke test', (WidgetTester tester) async {
    bool mainPressed = false;
    bool secondaryPressed = false;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MainButton(
                  text: 'Submit',
                  onPressed: () {
                    mainPressed = true;
                  },
                ),
                SecondaryButton(
                  text: 'Cancel',
                  onPressed: () {
                    secondaryPressed = true;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Submit'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(mainPressed, isTrue);

    await tester.tap(find.text('Cancel'));
    await tester.pump();
    expect(secondaryPressed, isTrue);
  });
}
