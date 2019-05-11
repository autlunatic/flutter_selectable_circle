# selectable_circle

A Flutter package for an Circle that can be Selected with animation.

## How to use

    SelectableCircleText(
        width: 80.0,
        onSelected: () {
        setState(() {
            _isSelected2 = !_isSelected2;
        });
        },
        child: Icon(Icons.star),
    );

## Screenshot

<img src="https://github.com/autlunatic/flutter_selectable_circle/blob/master/screenshots/sc.png?raw=true" width="240"/>

<img src="https://github.com/autlunatic/flutter_selectable_circle/blob/master/screenshots/sc.gif?raw=true" width="240"/>

## Parameters

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

    /// changes the selectmode
    ///
    /// Possible Values:
    /// simple: no animation, only selectedColor is used
    /// animatedCircle: Animation is used (default)
    /// check: Check Icon Animation is used
    final SelectMode selectMode;
