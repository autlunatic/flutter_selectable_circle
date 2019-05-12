library selectable_circle;

import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

/// Displays a Circle with a border wich can be selected.
///
/// [onTap] event is called, when the user taps on the circle
/// For [SelectMode.check] the [borderColor] is the check path
/// and the [selectedColor] is the color of the small animated circle
class SelectableCircle extends StatelessWidget {
  SelectableCircle({
    Key key,
    @required this.width,
    this.onTap,
    Widget child,
    bool isSelected,
    this.color,
    this.borderColor,
    this.selectedColor,
    this.selectedBorderColor,
    this.bottomDescription,
    SelectMode selectMode,
  })  : isSelected = isSelected ?? false,
        selectMode = selectMode ?? SelectMode.animatedCircle,
        child = child ?? Container(),
        _controller =
            MyFlareController(borderColor, selectedColor, selectedBorderColor),
        super(key: key);

  /// the width and height of the CircleWidget
  final double width;

  /// is called when the circle is tapped
  final VoidCallback onTap;

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

  /// widget that is displayed below the Circle for descriptions
  final Widget bottomDescription;

  /// changes the selectmode
  ///
  /// Possible Values:
  /// simple: no animation, only selectedColors are used
  /// animatedCircle: Animation is used (default)
  /// check: Check Icon Animation is used
  final SelectMode selectMode;

  final FlareController _controller;

  static const checkAsset = "packages/selectable_circle/flare/check.flr";
  static const spinningAsset = "packages/selectable_circle/flare/spinning.flr";
  static const spinningAnimation = "Spinning Circle";
  static const idleAnimation = "idle";
  static const checkAnimation = "Check";

  @override
  Widget build(BuildContext context) {
    final c = isSelected && selectMode != SelectMode.check
        ? selectedColor ?? Theme.of(context).backgroundColor
        : color ?? Theme.of(context).scaffoldBackgroundColor;
    final bc = isSelected && selectMode != SelectMode.check
        ? selectedBorderColor ?? Theme.of(context).buttonColor
        : borderColor ?? Theme.of(context).textTheme.body1.color;
    final borderWidth =
        selectMode == SelectMode.simple && isSelected ? 3.0 : 1.5;

    return Column(children: [
      GestureDetector(
        child: Stack(
          children: [
            if (selectMode == SelectMode.animatedCircle)
              isSelected
                  ? _buildSpinningCircle(spinningAnimation)
                  // i draw a smaller idle Animation below the not selected Circle
                  // for smoother click feeling, because
                  // flare flashes when it is built with animation,
                  // maybe there is a better solution, or the flare file needs to be updated
                  : _buildSpinningCircle(idleAnimation),
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
                  alignment: Alignment(0.80, 0.80),
                  child: isSelected
                      ? _buildCheckAnimation(checkAnimation)
                      : _buildCheckAnimation(idleAnimation),
                ),
              ),
          ],
        ),
        onTap: () => _select(),
      ),
      if (bottomDescription != null) bottomDescription,
    ]);
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
    if (onTap != null) {
      onTap();
    }
  }

  Widget _buildSpinningCircle(String animation) {
    final edgeinsets = (animation == 'idle') ? 10.0 : 4.0;
    return Container(
      padding: EdgeInsets.all(edgeinsets),
      width: width,
      height: width,
      child: Center(
        child: FlareActor(spinningAsset,
            alignment: Alignment.center,
            fit: BoxFit.fitHeight,
            controller: _controller,
            animation: animation),
      ),
    );
  }

  Widget _buildCheckAnimation(
    String animation,
  ) {
    final width = (animation == 'idle') ? 0.0 : 30.0;
    return Container(
      width: width,
      height: width,
      child: Center(
        child: FlareActor(checkAsset,
            alignment: Alignment.center,
            fit: BoxFit.fitHeight,
            controller: _controller,
            animation: animation),
      ),
    );
  }
}

enum SelectMode { simple, animatedCircle, check }

class MyFlareController with FlareController {
  MyFlareController(
      this.borderColor, this.selectedColor, this.selectedBorderColor);

  final Color borderColor;
  final Color selectedColor;
  final Color selectedBorderColor;
  FlutterColorFill _fillSelected;
  FlutterColorStroke _strokeSelectedBorder;
  FlutterColorStroke _strokeBorder;

  static const checkShape = "Check";
  static const spinnerShape = "Loading Spinner";
  static const ellipseShape = "Green Ellipse";
  static const whiteCircleShape = "White Circle";
  static const clippingCircleShape = "Clipping Circle";

  void initialize(FlutterActorArtboard artboard) {
    if (selectedColor != null) {
      FlutterActorShape shape = artboard.getNode(ellipseShape);
      _fillSelected = shape?.fill as FlutterColorFill;
      if (_fillSelected == null) {
        shape = artboard.getNode(clippingCircleShape);
        _fillSelected = shape?.fill as FlutterColorFill;
      }
    }
    if (selectedBorderColor != null) {
      FlutterActorShape shape = artboard.getNode(checkShape);
      _strokeSelectedBorder = shape?.stroke as FlutterColorStroke;
      if (_strokeSelectedBorder == null) {
        shape = artboard.getNode(spinnerShape);
        _strokeSelectedBorder = shape?.stroke as FlutterColorStroke;
      }
    }
    if (borderColor != null) {
      FlutterActorShape shape = artboard.getNode(whiteCircleShape);
      _strokeBorder = shape?.stroke as FlutterColorStroke;
    }
  }

  void setViewTransform(Mat2D viewTransform) {}

  bool advance(FlutterActorArtboard artboard, double elapsed) {
    // advance is called whenever the flare artboard is about to update (before it draws).
    if (_fillSelected != null) {
      _fillSelected.uiColor = selectedColor;
    }
    if (_strokeSelectedBorder != null) {
      _strokeSelectedBorder.uiColor = selectedBorderColor;
    }
    if (_strokeBorder != null) {
      _strokeBorder.uiColor = borderColor;
    }

    // Return false as we don't need to be called again. You'd return true if you wanted to manually animate some property.
    return false;
  }
}
