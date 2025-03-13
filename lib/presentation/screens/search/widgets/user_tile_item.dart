import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weighted_auto_complete_search/data/models/response/github_user_response_model.dart';

class UserTileItem extends StatelessWidget {
  const UserTileItem({
    required this.user,
    super.key,
  });

  final GithubUserResponseModel? user;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              user?.avatarUrl ?? '',
            ),
            radius: 20.r,
          ),
          if (user?.userName?.isNotEmpty ?? false) ...[
            SizedBox(width: 12.w),
            Flexible(
              child: Text(
                user?.userName ?? "",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
