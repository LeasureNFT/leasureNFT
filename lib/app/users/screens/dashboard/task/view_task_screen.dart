import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:leasure_nft/app/users/screens/dashboard/task/controller/user_task_controller.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ViewTaskScreen extends StatelessWidget {
  final QueryDocumentSnapshot task;

  ViewTaskScreen({super.key, required this.task});

  final UserTaskController controller = Get.put(UserTaskController());

  @override
  Widget build(BuildContext context) {
    controller.initializePlayer(task["url"]);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                  title: "Watch & Rate Video",
                  ontap: () {
                    Get.back();
                  }),
              SizedBox(height: 20.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: YoutubePlayer(
                  enableFullScreenOnVerticalDrag: true,
                  controller: controller.youtubeController,
                ),
              ),
              SizedBox(height: 10.h),
              Obx(() => Text(
                    "Duration: ${controller.videoDuration.value}",
                    style: AppTextStyles.adaptiveText(context, 14)
                        .copyWith(fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 20),
              Text(
                'Rate this Video :',
                style: AppTextStyles.adaptiveText(context, 16),
              ),
              SizedBox(height: 10.h),
              Obx(
                () => RatingBar.builder(
                  initialRating: controller.rating.value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) => controller.updateRating(rating),
                ),
              ),
              SizedBox(height: 10.h),
              Obx(() => Text(
                    "Rating: ${controller.rating.value}",
                    style: AppTextStyles.adaptiveText(context, 14)
                        .copyWith(fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 20.h),
              Obx(
                () => controller.isVideoEnded.value
                    ? CustomButton(
                        onPressed: () async {
                          await controller.submitTask(
                            url: task["url"],
                            rating: controller.rating.value,
                            taskName: task["title"],
                            taskDesc: task["description"],
                          );
                        },
                        loading: controller.isLoading.value,
                        text: "Done")
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
