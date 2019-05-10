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
    SelectMode selectMode,
  })  : isSelected = isSelected ?? false,
        selectMode = selectMode ?? SelectMode.animatedCircle,
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
  final Color selectedColor;

  /// Color of the border when selected
  final Color selectedBorderColor;

  final SelectMode selectMode;

  @override
  Widget build(BuildContext context) {
    final c = isSelected && selectMode != SelectMode.check
        ? selectedColor ?? Theme.of(context).backgroundColor
        : color ?? Theme.of(context).scaffoldBackgroundColor;
    final bc = isSelected && selectMode != SelectMode.check
        ? selectedBorderColor ?? Theme.of(context).buttonColor
        : borderColor ?? Theme.of(context).textTheme.body1.color;
    final borderWidth = isSelected ? 4.0 : 1.0;

    return GestureDetector(
      child: Stack(
        children: [
          if (selectMode == SelectMode.animatedCircle)
            isSelected
                ? _buildSpinningAnimation("Spinning Circle")
                // i draw a smaller idle Animation below the not selected Circle
                // for smoother click feeling, because
                // flare flashes when it is built with animation,
                // maybe there is a better solution, or the flare file needs to be updated
                : _buildSpinningAnimation("idle"),
          if (selectMode != SelectMode.animatedCircle || !isSelected)
            _buildCircle(c, bc, borderWidth),
          Container(
            height: width,
            width: width,
            child: Center(child: child),
          ),
          if (selectMode == SelectMode.check)
            Container(
              height: width,
              width: width,
              child: Align(
                alignment: Alignment(0.85, 0.85),
                child: isSelected
                    ? _buildSpinningAnimation("Check", fixedWidth: 40.0)
                    : _buildSpinningAnimation("idle", fixedWidth: 0.0),
              ),
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

  Widget _buildSpinningAnimation(String animation, {double fixedWidth}) {
    final edgeinsets = (animation == 'idle') ? 10.0 : 4.0;
    final asset = fixedWidth != null
        ? "packages/selectable_circle/flare/check.flr"
        : "packages/selectable_circle/flare/spinning.flr";

    return Container(
      padding: EdgeInsets.all(edgeinsets),
      width: fixedWidth ?? width,
      height: fixedWidth ?? width,
      child: Center(
        child: FlareActor(asset,
            alignment: Alignment.center,
            fit: BoxFit.fitHeight,
            animation: animation),
      ),
    );
  }
}

enum SelectMode { simple, animatedCircle, check }
