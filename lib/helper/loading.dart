import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressHelper {
  // Show Loader
  void showLoader(String? text) {
    // Loader(text);
    Get.dialog(
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ]),
              child: const SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text ?? 'Loading...',
            style: Get.textTheme.titleSmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
 
  }

  // Hide Loader
  static void hideLoader() {
    // remove everything from the stack
    Get.back();
  }
}

// class Loader {
//   final String? text;
//   Loader(this.text) {
//     Get.dialog(
//       Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Container(
//               height: 100,
//               width: 100,
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(.5),
//                       blurRadius: 3,
//                       offset: const Offset(0, 1),
//                     ),
//                   ]),
//               child: const SizedBox(
//                 height: 50,
//                 width: 50,
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             text ?? 'Loading...',
//             style: Get.textTheme.titleSmall!.copyWith(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
