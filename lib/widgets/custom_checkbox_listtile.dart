import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final String text;
  final bool value;
  final bool tristate;
  final Color activeColor;
  final Color checkColor;
  final ListTileControlAffinity controlAffinity;
  final TextStyle textStyle;
  final Function(bool) onChanged;
  final BoxDecoration decoration;

  const CustomCheckboxListTile({
    Key key,
    this.tristate,
    this.activeColor,
    this.checkColor,
    this.controlAffinity,
    this.text,
    this.value,
    this.textStyle,
    this.onChanged,
    this.decoration,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration == null ? null : decoration,
      child: CheckboxListTile(
        activeColor: activeColor == null ? null : activeColor,
        checkColor: checkColor == null ? null : checkColor,
        controlAffinity: controlAffinity == null
            ? ListTileControlAffinity.leading
            : controlAffinity,
        tristate: tristate == null ? false : tristate,
        title: Text(
          text,
          style: textStyle == null ? null : textStyle,
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
