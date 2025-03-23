import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/constants.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                    title: "About Us",
                    ontap: () {
                      Get.back();
                    }),
                SizedBox(height: screenHeight * 0.03),
                Center(
                  child: CircleAvatar(
                    radius: screenHeight * 0.09,
                    backgroundImage: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Welcome to Leasure NFT',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Leasure NFT is your trusted partner for NFT investments. Our platform provides a seamless way to explore, invest, and manage your NFT portfolio with ease. We are committed to simplifying the NFT investment journey for everyone.',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.036,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Our Features:',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.046,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    featureItem(screenWidth,
                        'Secure and transparent NFT transactions.'),
                    featureItem(
                        screenWidth, 'Real-time market analysis and insights.'),
                    featureItem(
                        screenWidth, 'Customizable NFT portfolio tracking.'),
                    featureItem(screenWidth,
                        'Educational resources for NFT beginners.'),
                    featureItem(
                        screenWidth, '24/7 customer support to assist you.'),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Our Mission:',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'At Leasure NFT, our mission is to empower investors by providing a user-friendly platform to explore the world of NFTs. We aim to make NFT investments accessible, secure, and rewarding for everyone.',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.036,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Contact Us:',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Icon(Icons.email,
                        color: kPrimaryColor, size: screenWidth * 0.06),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      'support@leasurenft.com',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.036,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Icon(Icons.phone,
                        color: kPrimaryColor, size: screenWidth * 0.06),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      '+92 3070217843',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.037,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                Center(
                  child: Text(
                    '© 2025 Leasure NFT. All rights reserved.',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget featureItem(double screenWidth, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle,
              color: kPrimaryColor, size: screenWidth * 0.05),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.036,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
