// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class PickImageWidget extends StatelessWidget {
//   const PickImageWidget({super.key, this.pickedImage, required this.function});
//   final XFile? pickedImage;
//   final Function function;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8.0),
//             child: pickedImage == null
//                 ? Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.0),
//                       border: Border.all(color: Colors.grey),
//                     ),
//                   )
//                 : Image.file(
//                     File(
//                       pickedImage!.path,
//                     ),
//                     fit: BoxFit.fill,
//                   ),
//           ),
//         ),
//         Positioned(
//           top: 0,
//           right: 0,
//           child: Material(
//             borderRadius: BorderRadius.circular(16.0),
//             color: Colors.lightBlue,
//             child: InkWell(
//               splashColor: Colors.red,
//               borderRadius: BorderRadius.circular(16.0),
//               onTap: () {
//                 function();
//               },
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Icon(
//                   Icons.add_photo_alternate_rounded,
//                   size: 20,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key, this.pickedImage, required this.function});
  final XFile? pickedImage;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: pickedImage == null
                  ? const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                        size: 50,
                      ),
                    )
                  : Image.file(
                      File(pickedImage!.path),
                      width: double.infinity, // make the image take full width
                      height:
                          double.infinity, // make the image take full height
                      fit: BoxFit.cover, // ensure the image covers the area
                    ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.lightBlue,
            child: InkWell(
              splashColor: Colors.red,
              borderRadius: BorderRadius.circular(16.0),
              onTap: () {
                function();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_photo_alternate_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
