import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that can be hidden by scrolling up and shown by scrolling down.
///
/// The widget is hidden when the user scrolls up and shown when the user scrolls down.
/// The animation of hiding and showing is done with a duration equal to [duration].
///
/// The [ScrollController] must be passed to the constructor.
/// The [child] is the widget to be hidden or shown.
class ScrollToHideWidget extends StatefulWidget {
  const ScrollToHideWidget({
    super.key,
    required this.scrollController,
    required this.child,
    this.duration = const Duration(
        milliseconds: 300), // Adjust duration for smoother animation
  });

  final ScrollController scrollController;
  final Widget child;
  final Duration duration;

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    final direction = widget.scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward && !isVisible) {
      setState(() {
        isVisible = true;
      });
    } else if (direction == ScrollDirection.reverse && isVisible) {
      setState(() {
        isVisible = false;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? kBottomNavigationBarHeight : 0,
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: isVisible ? 1.0 : 0.0, // Smooth fade effect
        child: Wrap(
          children: [widget.child],
        ),
      ),
    );
  }
}
