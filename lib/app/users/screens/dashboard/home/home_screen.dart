// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:leasure_nft/screens/dashboard/home/payment_method_screen.dart';

// class HomeScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> plans = [
//     {
//       "title": "VIP 1",
//       "price": "666 Rs",
//       "daily": "130 PKR",
//       "commission": "13%",
//       "term": "40 Days",
//     },
//     {
//       "title": "VIP 2",
//       "price": "760 Rs",
//       "daily": "145 PKR",
//       "commission": "15%",
//       "term": "48 Days",
//     },
//     {
//       "title": "VIP 3",
//       "price": "815 Rs",
//       "daily": "150 PKR",
//       "commission": "16%",
//       "term": "50 Days",
//     },
//     {
//       "title": "VIP 4",
//       "price": "2075 Rs",
//       "daily": "380 PKR",
//       "commission": "16%",
//       "term": "50 Days",
//     },
//     {
//       "title": "VIP 5",
//       "price": "4600 Rs",
//       "daily": "830 PKR",
//       "commission": "16%",
//       "term": "50 Days",
//     },
//     {
//       "title": "VIP 6",
//       "price": "9200 Rs",
//       "daily": "1660 PKR",
//       "commission": "16%",
//       "term": "50 Days",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         drawer: Drawer(),
//         appBar: AppBar(
//           backgroundColor: Colors.pinkAccent,
//           // automaticallyImplyLeading: false,
//           iconTheme: IconThemeData(color: Colors.white),
//           title: Text(
//             "Investment Plans",
//             style: GoogleFonts.poppins(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//                   SizedBox(
//                     height: 8,
//                   ),
//               Card(
//                   color: Colors.white, // Set the card color to white
//                   elevation: 5, // Shadow effect to make the card pop
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15), // Rounded corners
//                   ),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.all(16.0), // Padding inside the card
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'Investment Packages',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 16,
//                                 color: Colors.pinkAccent,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(height: 6),
//                             Text(
//                               'Invest now to earn money',
//                               style: GoogleFonts.inter(fontSize: 14,),
//                             ),
//                           ],
//                         ),

//                         // Icon(Icons.vpn_key_outlined)
//                         Image.asset('assets/images/vip.png',height: Get.width*.22,)
//                       ],
//                     ),
//                   )),

//                   SizedBox(
//                     height: 22,
//                   ),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10.0,
//                     mainAxisSpacing: 10.0,
//                     childAspectRatio: 0.7,
//                   ),
//                   itemCount: plans.length,
//                   itemBuilder: (context, index) {
//                     return InvestmentCard(
//                       title: plans[index]["title"],
//                       price: plans[index]["price"],
//                       daily: plans[index]["daily"],
//                       commission: plans[index]["commission"],
//                       term: plans[index]["term"],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class InvestmentCard extends StatelessWidget {
//   final String title;
//   final String price;
//   final String daily;
//   final String commission;
//   final String term;

//   const InvestmentCard({
//     required this.title,
//     required this.price,
//     required this.daily,
//     required this.commission,
//     required this.term,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.pinkAccent, Colors.pink.shade200],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image.asset(
//             //   'assets/images/logo.png', // Replace with your image
//             //   height: 60,
//             //   width: 60,
//             // ),

//             Center(
//               child: Icon(
//                 Icons.payment,
//                 color: Colors.white,
//                 size: 55,
//               ),
//             ),
//             Center(
//               child: Text(
//                 title,
//                 style: GoogleFonts.poppins(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Price: $price",
//                   style: GoogleFonts.poppins(color: Colors.white),
//                 ),
//                 Text(
//                   "Daily: $daily",
//                   style: GoogleFonts.poppins(color: Colors.white),
//                 ),
//                 Text(
//                   "Commission: $commission",
//                   style: GoogleFonts.poppins(color: Colors.white),
//                 ),
//                 Text(
//                   "Term: $term",
//                   style: GoogleFonts.poppins(color: Colors.white),
//                 ),
//               ],
//             ),
//             Center(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16.0),
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.to(()=>PaymentMethodScreen(plan: title, price: price));
//                 },
//                 child: Text(
//                   "Invest Now",
//                   style: GoogleFonts.poppins(
//                     color: Colors.pinkAccent,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leasure_nft/constants.dart';
import 'package:leasure_nft/app/users/screens/dashboard/home/payment_method_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight * 0.2,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => PaymentMethodScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.013,
                  horizontal: screenWidth * 0.06,
                ),
              ),
              child: Text(
                'Select paymen',
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.035,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
