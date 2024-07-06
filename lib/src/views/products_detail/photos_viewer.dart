import 'package:flutter/material.dart';

import '../network_image.dart';
import 'current_item_indicator.dart';

// displays all photos belonging to a product in a carousel manner,
// using the swipe gesture
class PhotosViewer extends StatefulWidget {
  const PhotosViewer({super.key, required this.photos});
  final List<String> photos;

  @override
  State<PhotosViewer> createState() => _PhotosViewerState();
}

class _PhotosViewerState extends State<PhotosViewer> {
  final _controller = PageController();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.photos.length,
          onPageChanged: (i) => setState(() => _currentIndex = i),
          itemBuilder: (_, i) {
            final photo = widget.photos[i];
            return CustomNetworkImage(url: photo, fit: BoxFit.cover);
          },
        ),
        Positioned(
          bottom: 10.0,
          child: Row(
            children: [
              for (var i = 0; i < widget.photos.length; i++) ...[
                CurrentItemIndicator(isCurrentPage: _currentIndex == i),
                const SizedBox(width: 4.0),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
