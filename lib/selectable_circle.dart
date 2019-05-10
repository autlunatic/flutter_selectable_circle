library selectable_circle;

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

/// A Calculator.
class SelectableCircle extends StatelessWidget {
  SelectableCircle({
    Key key,
    @required this.width,
    this.onSelected,
    Widget child,
    bool isSelected,
    this.color,
    this.borderColor,
    this.selectedColor,
    this.selectedBorderColor,
  })  : isSelected = isSelected ?? false,
        child = child ?? Container(),
        super(key: key);

  /// the width and height of the CircleWidget
  final double width;

  /// is called when the circle is tapped
  final VoidCallback onSelected;

  /// child displayed on top of the circle
  final Widget child;

  /// widget should be displayed as selected
  final bool isSelected;

  /// Color of the circle
  final Color color;

  /// borderColor of the circle
  final Color borderColor;

  /// Color of the circle when selected
  ///
  /// this option also disables the animation!
  final Color selectedColor;

  /// Color of the border when selected
  ///
  /// this option also disables the animation!
  final Color selectedBorderColor;

  @override
  Widget build(BuildContext context) {
    final hasSelectedColors =
        selectedBorderColor != null || selectedColor != null;
    final c = isSelected
        ? selectedColor ?? Theme.of(context).backgroundColor
        : color ?? Theme.of(context).scaffoldBackgroundColor;
    final bc = isSelected
        ? selectedBorderColor ?? Theme.of(context).buttonColor
        : borderColor ?? Theme.of(context).textTheme.body1.color;
    final borderWidth = isSelected ? 4.0 : 1.0;

    return GestureDetector(
      child: Stack(
        children: [
          if (!hasSelectedColors)
            isSelected
                ? _buildSpinningAnimation(bc, "Spinning Circle")
                // i draw a smaller idle Animation below the not selected Circle
                // for smoother click feeling, because
                // flare flashes when it is built with animation,
                // maybe there is a better solution, or the flare file needs to be updated
                : _buildSpinningAnimation(bc, "idle"),
          if (hasSelectedColors || !isSelected)
            _buildCircle(c, bc, borderWidth),
          Container(
            height: width,
            width: width,
            child: Center(child: child),
          ),
        ],
      ),
      onTap: () => _select(),
    );
  }

  Container _buildCircle(Color color, Color borderColor, double borderWidth) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: width,
      height: width,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(color: borderColor, width: borderWidth)),
        ),
      ),
    );
  }

  _select() {
    if (onSelected != null) {
      onSelected();
    }
  }

  Widget _buildSpinningAnimation(Color borderColor, String animation) {
    final edgeinsets = (animation == 'idle') ? 10.0 : 4.0;

    return Container(
      padding: EdgeInsets.all(edgeinsets),
      width: width,
      height: width,
      child: Center(
        child: FlareActor("packages/selectable_circle_text/flare/spinning.flr",
            alignment: Alignment.center,
            fit: BoxFit.fitHeight,
            animation: animation),
      ),
    );
  }
}
