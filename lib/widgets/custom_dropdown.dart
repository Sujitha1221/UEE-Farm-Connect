import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_structure/core/app_export.dart';
import 'package:form_structure/presentation/add_crop_screen/add_crop_screen.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T value;
  final ValueChanged<T> onChanged;
  final Widget Function(T item) itemBuilder;

  CustomDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemBuilder,
  });

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  bool isDropdownOpened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isDropdownOpened = !isDropdownOpened;
            });
          },
          child: Container(
            padding:
                EdgeInsets.only(top: 6.h, right: 12.h, bottom: 6.h, left: 20.h),
            margin: EdgeInsets.fromLTRB(27.h, 15.v, 25.h, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green[900]!),
              borderRadius: BorderRadius.circular(26.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.grass,
                  color: Colors.green[900]!,
                  size: 30.h,
                ),
                widget.itemBuilder(widget.value),
                Icon(isDropdownOpened
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (isDropdownOpened)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.fromLTRB(27.h, 15.v, 25.h, 15.v),
            child: Column(
              children: widget.items.map((item) {
                return InkWell(
                  onTap: () {
                    widget.onChanged(item);
                    setState(() {
                      isDropdownOpened = false;
                    });
                  },
                  child: widget.itemBuilder(item),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
