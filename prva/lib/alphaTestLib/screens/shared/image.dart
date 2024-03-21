

import 'package:flutter/material.dart';

class ImagesTile extends StatelessWidget {
  final String image;
  const ImagesTile({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              image,
              height: MediaQuery.sizeOf(context).height * 0.38,
              width: MediaQuery.sizeOf(context).height * 0.25,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}