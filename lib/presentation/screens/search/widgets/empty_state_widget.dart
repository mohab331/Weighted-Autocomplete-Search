import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.icon = Icons.person_off_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 80.r, color: Colors.grey.shade400),
          SizedBox(
            height: 12.h,
          ),
          Flexible(
            child: Text(
              message,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
