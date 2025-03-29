import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/users/screens/contact_us/controller/contact_us_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
        init: ContactUsController(),
        builder: ((controller) => Scaffold(
              body: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Header(
                          title: "Contact Us",
                          ontap: () {
                            Get.back();
                          }),
                      SizedBox(height: 20.h),

                      // Logo
                      Center(
                        child: CircleAvatar(
                          radius: 60.r,
                          backgroundImage: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // Contact Title
                      Center(
                        child: Text(
                          'Get in Touch with Leasure NFT',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Email
                      contactItem(
                        icon: Icons.email,
                        label: "Email",
                        value: "leasurenft.suport@gmail.com",
                        onTap: () async {
                          // Copy email to clipboard
                          Clipboard.setData(ClipboardData(
                              text: "leasurenft.suport@gmail.com"));

                          // Open Gmail
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: "leasurenft.suport@gmail.com",
                          );
                          launchUrl(emailLaunchUri);
                        },
                      ),

                      contactItem(
                        icon: Icons.phone,
                        label: "Phone",
                        value: "+92 349 0686818",
                        onTap: () {
                          // Copy phone number to clipboard
                          Clipboard.setData(
                              ClipboardData(text: "+92 349 0686818"));
                          Fluttertoast.showToast(
                            msg: "Phone number copied to clipboard",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          );
                        },
                      ),

                      // Phone Number

                      // Website
                      contactItem(
                        icon: Icons.web,
                        label: "Whatsapp Channel",
                        value: "Leasure NFT",
                        onTap: () async {
                          if (await canLaunchUrl(Uri.parse(
                              "https://whatsapp.com/channel/0029VbAUg4UE50UaeIm4xz0w"))) {
                            await launchUrl(
                                Uri.parse(
                                    "https://whatsapp.com/channel/0029VbAUg4UE50UaeIm4xz0w"),
                                mode: LaunchMode.externalApplication);
                          } else {
                            Get.log(
                                "❌ Could not launch https://whatsapp.com/channel/0029VbAUg4UE50UaeIm4xz0w}");
                          }
                        },
                      ),

                      // Address
                      contactItem(
                        icon: Icons.telegram,
                        label: "Telegram",
                        value: "Leasure NFT",
                        onTap: () async {
                          if (await canLaunchUrl(
                              Uri.parse("https://t.me/leasure_nft"))) {
                            await launchUrl(
                                Uri.parse("https://t.me/leasure_nft"),
                                mode: LaunchMode.externalApplication);
                          } else {
                            Get.log(
                                "❌ Could not launch https://t.me/leasure_nft}");
                          }
                        },
                      ),

                      SizedBox(height: 10.h),

                      // Social Media Links

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     socialMediaButton(
                      //         Icons.facebook, facebook, controller),
                      //     socialMediaButton(Icons.mark_chat_unread_outlined,
                      //         twitter, controller),
                      //     socialMediaButton(
                      //         Icons.camera_alt, instagram, controller),
                      //     socialMediaButton(
                      //       Icons.business,
                      //       linkedin,
                      //       controller,
                      //     ),
                      //     socialMediaButton(
                      //       Icons.message,
                      //       whatsapp,
                      //       controller,
                      //     )
                      //   ],
                      // ),

                      SizedBox(height: 10.h),

                      // Footer
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '© 2025 Leasure NFT. All rights reserved.',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  // Widget for Contact Info
  Widget contactItem({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryColor, size: 24),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "$label: $value",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Social Media Buttons
}
