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
            child: Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}
