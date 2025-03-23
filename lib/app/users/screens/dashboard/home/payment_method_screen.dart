import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leasure_nft/constants.dart';
import 'package:leasure_nft/app/core/widgets/backbutton.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final List<Map<String, String>> paymentMethods = [
    {
      'title': 'JazzCash',
      'logoPath': 'assets/images/jazzcash.png',
      'accountName': 'Admin JazzCash',
      'accountNumber': '0301-1234567'
    },
    {
      'title': 'EasyPaisa',
      'logoPath': 'assets/images/easypaisa.png',
      'accountName': 'Admin EasyPaisa',
      'accountNumber': '0321-7654321'
    },
    {
      'title': 'Meezan Bank',
      'logoPath': 'assets/images/meezanbank.png',
      'accountName': 'Meezan Admin',
      'accountNumber': '1234567890'
    },
    {
      'title': 'HBL Bank',
      'logoPath': 'assets/images/hbl.png',
      'accountName': 'HBL Admin',
      'accountNumber': '0987654321'
    },
  ];

  void _navigateToUploadScreen(Map<String, String> paymentMethod) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PaymentDetailScreen(paymentMethod: paymentMethod),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        leading: BackNavigatingButton(color: Colors.white),
        title: Text(
          'Payment Method',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: screenWidth > 600 ? 1 : 0.6,
          ),
          itemCount: paymentMethods.length,
          itemBuilder: (context, index) {
            return PaymentCard(
              title: paymentMethods[index]['title']!,
              logoPath: paymentMethods[index]['logoPath']!,
              onTap: () {
                _navigateToUploadScreen(paymentMethods[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final String title;
  final String logoPath;
  final VoidCallback onTap;

  const PaymentCard({
    required this.title,
    required this.logoPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  logoPath,
                  height: 99,
                  width: 99,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 18,
                    ),
                  ),
                  child: Text(
                    'Invest now',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
