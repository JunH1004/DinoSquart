import 'dart:math';

import 'package:flutter/material.dart';

import 'item_widget.dart';

enum InitialPosition { start, center, end }

class HorizontalPicker extends StatefulWidget {
  final double minValue, maxValue;
  final int divisions;
  final double height;
  final Function(double) onChanged;
  final InitialPosition initialPosition;
  final Color backgroundColor;
  final bool showCursor;
  final Color cursorColor;
  final Color activeItemTextColor;
  final Color passiveItemsTextColor;
  final String suffix;
  final double itemBatch;
  HorizontalPicker({
    required this.minValue,
    required this.maxValue,
    required this.divisions,
    required this.height,
    required this.onChanged,
    required this.itemBatch,
    this.initialPosition = InitialPosition.center,
    this.backgroundColor = Colors.white,
    this.showCursor = true,
    this.cursorColor = Colors.red,
    this.activeItemTextColor = Colors.blue,
    this.passiveItemsTextColor = Colors.grey,
    this.suffix = "",
  }) : assert(minValue < maxValue);

  @override
  _HorizontalPickerState createState() => _HorizontalPickerState();
}

class _HorizontalPickerState extends State<HorizontalPicker> {
  late FixedExtentScrollController _scrollController;
  late int curItem;
  List<Map> valueMap = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i <= widget.divisions; i++) {
      valueMap.add({
        "value": widget.minValue +
            ((widget.maxValue - widget.minValue) / widget.divisions) * i,
        "fontSize": 8.0,
        "color": widget.passiveItemsTextColor,
      });
    }
    setScrollController();

    // 초기 선택 항목을 활성 상태로 설정
    int initialItem = 0; // 첫 번째 아이템을 선택
    valueMap[initialItem]["color"] = widget.activeItemTextColor;
    valueMap[initialItem]["fontSize"] = 32.0;
    valueMap[initialItem]["hasBorders"] = true;

    // 초기 선택 항목을 컨트롤러를 통해 UI로 업데이트
    _scrollController.jumpToItem(initialItem);
  }


  void setScrollController() {
    int initialItem = 0; // 항상 첫 번째 아이템을 선택하도록 설정
    _scrollController = FixedExtentScrollController(initialItem: initialItem);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: widget.height,
      alignment: Alignment.center,
      color: widget.backgroundColor,
      child: Stack(
        children: <Widget>[
          RotatedBox(
            quarterTurns: 3,
            child: ListWheelScrollView(
                controller: _scrollController,
                itemExtent: widget.itemBatch,
                onSelectedItemChanged: (item) {
                  curItem = item;
                  int decimalCount = 1;
                  num fac = pow(10, decimalCount);
                  valueMap[item]["value"] =
                      (valueMap[item]["value"] * fac).round() / fac;
                  widget.onChanged(valueMap[item]["value"]);
                  for (var i = 0; i < valueMap.length; i++) {
                    if (i == item) {
                      valueMap[item]["color"] = widget.activeItemTextColor;
                      valueMap[item]["fontSize"] = 32.0;
                      valueMap[item]["hasBorders"] = true;
                    } else {
                      valueMap[i]["color"] = widget.passiveItemsTextColor;
                      valueMap[i]["fontSize"] = 8.0;
                      valueMap[i]["hasBorders"] = true;
                    }
                  }
                  setState(() {});
                },
                children: valueMap.map((Map curValue) {
                  return ItemWidget(
                    curValue,
                    widget.backgroundColor,
                    widget.suffix,
                  );
                }).toList()),
          ),
          Visibility(
            visible: widget.showCursor,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: widget.cursorColor.withOpacity(0.3),
                ),
                width: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}

