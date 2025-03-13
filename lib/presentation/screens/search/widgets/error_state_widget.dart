import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorStateWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetry;

  const ErrorStateWidget({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: Colors.red.shade600,
            size: 95.r,
          ),
          SizedBox(
            height: 5.h,
          ),
          Flexible(
            child: Text(
              errorMessage ?? 'Something went wrong. Please try again later !',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 45.h,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r,), // Smooth rounded corners
                  ),
                  elevation: 2, // Subtle shadow
                ),
                child: Text(
                  "Retry",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )

          ],
        ],
      ),
    );
  }
}
