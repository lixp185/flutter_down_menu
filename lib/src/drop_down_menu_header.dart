import 'package:flutter/material.dart';

import 'menu_controller.dart';

/// 下拉组件头部 配合DropDownMenu 使用
class DropDownMenuHeader extends StatefulWidget {
  /// 菜单控制器
  final MenuController menuController;

  /// 头部显示数组
  final List<String> titles;

  /// 头部高度
  final double? headHeight;

  /// 默认文字 icon 色值
  final Color defaultColor;

  /// 点击色值
  final Color clickColor;

  /// icon大小
  final double? iconSize;

  /// 右边Icon
  final AssetImage? drawableEndAssetImg;

  const DropDownMenuHeader({
    Key? key,
    required this.menuController,
    required this.titles,
    this.headHeight,
    this.defaultColor = const Color(0xFF333333),
    this.clickColor = const Color(0xFFFF00FF),
    this.drawableEndAssetImg,
    this.iconSize,
  }) : super(key: key);

  @override
  _DropDownMenuHeaderState createState() => _DropDownMenuHeaderState();
}

class _DropDownMenuHeaderState extends State<DropDownMenuHeader> {
  final _children = <Widget>[];

  var currentIndex = -1;

  // 筛选头部显示的文本数组
  List<String> changeTitles = [];

  @override
  void initState() {
    super.initState();
    changeTitles.addAll(widget.titles);
    for (var i = 0; i < changeTitles.length; i++) {
      _children.add(searchFilter(changeTitles[i], i));
    }
    widget.menuController.addListener(() {
      // 下拉 true 隐藏 false
      var isShow = widget.menuController.isShow;
      setState(() {
        if (widget.menuController.title != "") {
          changeTitles[widget.menuController.titleIndex] =
              widget.menuController.title;
        } else {
          changeTitles[widget.menuController.titleIndex] =
              widget.titles[widget.menuController.titleIndex];
        }
        if (isShow && currentIndex < widget.titles.length) {
          currentIndex = widget.menuController.index;
        } else {
          currentIndex = -1;
        }
        _children.clear();
        for (var i = 0; i < changeTitles.length; i++) {
          _children.add(searchFilter(changeTitles[i], i));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.headHeight ?? 45,
      child: Row(children: _children),
    );
  }

  Widget searchFilter(String name, int index) {
    return Expanded(
        child: InkWell(
      child: Container(
        alignment: Alignment.center,
        child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: name,
                style: TextStyle(
                    color: currentIndex == index || widget.titles[index] != name
                        ? widget.clickColor
                        : widget.defaultColor),
                children: [
                  WidgetSpan(
                      child: widget.drawableEndAssetImg == null
                          ? Icon(
                              currentIndex == index
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: currentIndex == index ||
                                      widget.titles[index] != name
                                  ? widget.clickColor
                                  : widget.defaultColor,
                              size: widget.iconSize ?? 20,
                            )
                          : ImageIcon(
                              widget.drawableEndAssetImg,
                              color: currentIndex == index ||
                                      widget.titles[index] != name
                                  ? widget.clickColor
                                  : widget.defaultColor,
                              size: widget.iconSize ?? 20,
                            ))
                ])),
      ),
      onTap: () {
        if (index == currentIndex && widget.menuController.isShow) {
          widget.menuController.hide();
        } else {
          widget.menuController.show(index);
          print("index $index");
        }
      },
    ));
  }
}
