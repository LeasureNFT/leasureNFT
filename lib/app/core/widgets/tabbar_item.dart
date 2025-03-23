// import 'package:flutter/material.dart';

// class TabBarItem extends StatelessWidget {
//   final String title;
//   final bool isSelected;
//   final Color? unSelectedColor;

//   const TabBarItem({
//     super.key,
//     required this.title,
//     required this.isSelected,
//     this.unSelectedColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 4),
//           padding: EdgeInsets.symmetric(vertical: 8),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.orange : Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(14),
//           ),
//           alignment: Alignment.center,
//           child: Center(
//             child: Text(
//               title,
//               style: GoogleFonts.inter(
//                 color: isSelected ? Colors.white : Colors.black,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           )),
//     );
//   }
// }
