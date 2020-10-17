library parent_child_checkbox;

import 'package:flutter/material.dart';

import 'widgets/custom_checkbox_listtile.dart';

class ParentChildCheckBox extends StatefulWidget {
  /// Creates a box decoration.
  /// Creates a Parent checkbox with children chekcbox if given
  /// only [parentTitle] is required argument
  /// [parentTitle] is a String and cannot be empty
  /// [parentDefaultValue] initial value of the parent checkbox, true or false, or null if [isTristate] is true
  /// [parentTitleStyle] changing the style of parent title text
  /// [parentDecoration] parent checkbox decoration using [BoxDecoration()]
  /// [childrenTitleStyle] is a List of String children title and it is optional
  /// [childrenDefaultValue] initial value of the children checkbox, true or false
  /// [childrenTitleStyle] changing the style of all children title text
  /// [childrenDecoration] children checkbox decoration using [BoxDecoration()]
  /// [onChange] callback function to get result of parent and children checkboxes which are boolean
  /// [isTristate] whether the parent checkbox has three states, by dafault it has true, and false, when [isTriState] is true null will be added to parents value
  /// [childrenHorizontalPadding] ceates a horizontal padding to the children to make them appear as the parents children
  /// [activeColor] changing active color of the checkbox
  /// [checkColor] changing color of the check icon
  /// [controlAffinity] whether the check box appear as leading, trailing

  final String parentTitle;
  final TextStyle parentTitleStyle;
  final bool parentDefaultValue;
  final BoxDecoration parentDecoration;
  final List<String> childrenTitle;
  final TextStyle childrenTitleStyle;
  final bool childrenDefaultValue;
  final BoxDecoration childrenDecoration;
  final Function(bool, List<bool>) onChange;
  final bool isTristate;
  final double childrenHorizontalPadding;
  final Color activeColor;
  final Color checkColor;
  final ListTileControlAffinity controlAffinity;

  const ParentChildCheckBox({
    Key key,
    @required this.parentTitle,
    this.childrenTitle,
    this.onChange,
    this.isTristate,
    this.parentDefaultValue,
    this.childrenDefaultValue,
    this.childrenHorizontalPadding,
    this.parentTitleStyle,
    this.childrenTitleStyle,
    this.activeColor,
    this.checkColor,
    this.controlAffinity,
    this.parentDecoration,
    this.childrenDecoration,
  })  : assert(parentTitle != null,
            'ParenChildCheckBox: Parent title cannot be null'),
        super(key: key);
  @override
  _ParentChildCheckBoxState createState() => _ParentChildCheckBoxState();
}

class _ParentChildCheckBoxState extends State<ParentChildCheckBox> {
  ValueNotifier<bool> parentValue;
  List<ValueNotifier<bool>> childValue;
  @override
  void initState() {
    super.initState();
    parentValue = ValueNotifier<bool>((widget.parentDefaultValue != null
        ? widget.parentDefaultValue
        : false));
  }

  @override
  void didUpdateWidget(covariant ParentChildCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _intitialchildrenValue();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          builder: (BuildContext context, bool value, Widget child) {
            return CustomCheckboxListTile(
              decoration: widget.parentDecoration,
              activeColor: widget.activeColor,
              checkColor: widget.checkColor,
              controlAffinity: widget.controlAffinity,
              tristate: widget.isTristate,
              text: widget.parentTitle,
              textStyle: widget.parentTitleStyle,
              value: value,
              onChanged: (bool result) {
                parentValue.value = result ?? false;
                _changechildrenValueFromParent(value: result ?? false);
                _callingOnChangeCallbackFunction();
              },
            );
          },
          valueListenable: parentValue,
        ),
        widget.childrenTitle == null
            ? Container()
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.childrenHorizontalPadding == null
                        ? 40
                        : widget.childrenHorizontalPadding),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.childrenTitle.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ValueListenableBuilder(
                        builder:
                            (BuildContext context, bool value, Widget child) {
                          return CustomCheckboxListTile(
                            decoration: widget.childrenDecoration,
                            activeColor: widget.activeColor,
                            checkColor: widget.checkColor,
                            controlAffinity: widget.controlAffinity,
                            text: widget.childrenTitle[index],
                            textStyle: widget.childrenTitleStyle,
                            value: value,
                            onChanged: (bool result) {
                              childValue[index].value = result;
                              _checkChildrenValueToChangeParentValue();
                              _callingOnChangeCallbackFunction();
                            },
                          );
                        },
                        valueListenable: childValue[index],
                      );
                    }),
              )
      ],
    );
  }

  _changechildrenValueFromParent({@required bool value}) {
    if (widget.childrenTitle != null) {
      for (int i = 0; i < widget.childrenTitle.length; i++) {
        if (value != null) childValue[i].value = value;
      }
    }
  }

  _intitialchildrenValue() {
    /// initializing [childValue] to a default value
    /// if the [childValue] is already assigned value to it, it does not need anyupdates even so, didUpdateWidget called
    if (widget.childrenTitle != null) {
      if (widget.childrenTitle.length !=
          (childValue == null ? 0 : childValue.length)) {
        childValue = [];
        widget.childrenTitle.forEach((element) {
          childValue.add(ValueNotifier<bool>(
              (widget.childrenDefaultValue != null
                  ? widget.childrenDefaultValue
                  : false)));
        });
      }
    }
  }

  _callingOnChangeCallbackFunction() {
    if (widget.onChange != null)
      widget.onChange(
        parentValue.value,
        childValue == null
            ? null
            : childValue.map((e) => e.value).toList(),
      );
  }

  _checkChildrenValueToChangeParentValue() {
    if (widget.childrenTitle != null) {
      List<bool> _childrenValueAsListBool = [];
      childValue.forEach((element) {
        _childrenValueAsListBool.add(element.value);
      });
      if (widget.isTristate == null) {
        if (_childrenValueAsListBool.every((element) => element == true))
          parentValue.value = true;
        else
          parentValue.value = false;
      } else {
        if (widget.isTristate) {
          if (_childrenValueAsListBool.every((element) => element == true))
            parentValue.value = true;
          else if (_childrenValueAsListBool
              .every((element) => element == false))
            parentValue.value = false;
          else
            parentValue.value = null;
        } else {
          if (_childrenValueAsListBool.every((element) => element == true))
            parentValue.value = true;
          else
            parentValue.value = false;
        }
      }
    }
  }
}
