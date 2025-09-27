import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  const ImageCard({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        child: Image.asset(
          imageUrl,
          fit: fit,
          width: width ?? double.infinity,
          height: height,
          errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: height,
      width: width,
      color: const Color(0xFFD2B48C),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              'Image',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
