import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weighted_auto_complete_search/data/models/response/github_user_response_model.dart';

class UserProfileDialogue extends StatelessWidget {
  const UserProfileDialogue({required this.user, super.key});

  final GithubUserResponseModel? user;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
            user?.avatarUrl ?? '',
          ),
          radius: 50.r,
        ),
        if (user?.userName?.isNotEmpty ?? false) ...[
          SizedBox(height: 12.h),
          Flexible(
            child: Text(
              user?.userName ?? '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        if (user?.profileUrl?.isNotEmpty ?? false) ...[
          SizedBox(height: 12.h),
          Text(
            user?.profileUrl ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ],
    );
  }

}
