// class SensorCard extends StatelessWidget {

//   final String title;
//   final String value;
//   final String unit;
//   final IconData icon;
//   final Color color;

//   const SensorCard({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.unit,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {

//     return Card(

//       elevation: 6,

//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),

//       child: Padding(

//         padding: const EdgeInsets.all(16),

//         child: Column(

//           mainAxisAlignment: MainAxisAlignment.center,

//           children: [

//             Icon(icon, size: 48, color: color),

//             const SizedBox(height: 8),

//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 8),

//             Text(
//               '$value $unit',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),

//           ],

//         ),

//       ),

//     );

//   }

// }