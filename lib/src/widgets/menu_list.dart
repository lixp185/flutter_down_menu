import 'package:flutter/material.dart';
import 'package:flutter_down_menu/flutter_down_menu.dart';

enum Choose {
  Single, // 单选
  Multi // 多选
}

/// 示例 下拉组件
class MenuList extends StatefulWidget {
  /// 筛选数据
  final List<FilterRes> filterList;

  /// 选择回调
  final Function(int index)? onTap;

  /// 自定义item
  final Widget? itemWidget;

  /// 选择控制器
  final MenuController menuController;

  /// 下拉菜单index
  final int index;

  const MenuList(
      {Key? key,
      required this.filterList,
      this.onTap,
      this.itemWidget,
      required this.menuController,
      required this.index})
      : super(key: key);

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
      padding: const EdgeInsetsDirectional.only(bottom: 10),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //设置列数
          crossAxisCount: 1,
          //设置横向间距
          crossAxisSpacing: 10,
          //设置主轴间距
          mainAxisSpacing: 10,
          // 宽高比
          childAspectRatio: 9,
        ),
        itemBuilder: (context, index) {
          return InkWell(
              child: widget.itemWidget ??
                  Container(
                      decoration: BoxDecoration(
                          color: widget.filterList[index].isSelect == true
                              ? const Color(0x0DAB4BF4)
                              : Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              color: widget.filterList[index].isSelect == true
                                  ? const Color(0xffab4bf4)
                                  : const Color(0xffacacac))),
                      alignment: Alignment.center,
                      child: Text(widget.filterList[index].name ?? "",
                          style: TextStyle(
                              color: widget.filterList[index].isSelect == true
                                  ? const Color(0xffab4bf4)
                                  : const Color(0xffacacac)))),
              onTap: () {
                widget.menuController
                    .changeTitle(widget.index, widget.filterList[index].name);
                setState(() {
                  for (int i = 0; i < widget.filterList.length; i++) {
                    if (i == index) {
                      widget.filterList[i].isSelect = true;
                    } else {
                      widget.filterList[i].isSelect = false;
                    }
                  }
                });
                if (widget.onTap != null) widget.onTap!(index);
              });
        },
        itemCount: widget.filterList.length,
      ),
    );
  }
}
