import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int secondsRemaining = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        if (mounted) {
          setState(() {
            secondsRemaining--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        secondsRemaining == 0
        ? const SizedBox.shrink()
        : Text.rich(
          TextSpan(
            text: 'Resend code in ',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 16.sp,
            ),
            // style: TextStyle(fontSize: 16.sp, color: AppColors.black, fontWeight: FontWeight.w400),
            children: [
              TextSpan(
                text: secondsRemaining < 10 ? '00:0$secondsRemaining' : '00:$secondsRemaining',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                // style: TextStyle(fontSize: 16.sp, color: AppColors.blue, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
