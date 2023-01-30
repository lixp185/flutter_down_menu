import 'package:flutter/material.dart';
import 'package:flutter_down_menu/flutter_down_menu.dart' as m;
import 'package:flutter_down_menu/flutter_down_menu.dart';

///支持 单选、多选列表
/// 2级列表单选、多选

enum Choose {
  single, // 单选
  multi // 多选
}

/// 示例 下拉组件
class MenuList extends StatefulWidget {
  /// 筛选数据
  final List<FilterBean> filterList;

  /// 选择回调
  final Function(int index)? onTap;

  /// 选择控制器
  final m.MenuController menuController;

  /// 下拉菜单index
  final int index;

  final Choose choose;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final int crossAxisCount;
  final double? mainAxisExtent;

  /// item背景色
  final Color bgColor;
  final Color unBgColor;

  /// 边框色
  final Color outLineColor;
  final Color unOutLineColor;
  final BoxBorder? border;

  /// 文字色
  final Color fontColor;
  final Color unFontColor;

  final double fontSize;
  final double radius;

  /// item对齐方式
  final AlignmentGeometry? itemAlignment;

  /// 竖向间距
  final double mainAxisSpacing;

  /// 横向间距
  final double crossAxisSpacing;

  /// 下拉布局装饰
  final Decoration? decoration;
  final Color? color;

  const MenuList({
    Key? key,
    required this.filterList,
    this.onTap,
    required this.menuController,
    required this.index,
    this.choose = Choose.single,
    this.margin,
    this.padding,
    this.crossAxisCount = 1,
    this.bgColor = const Color(0x0DAB4BF4),
    this.unBgColor = Colors.white,
    this.outLineColor = const Color(0xffab4bf4),
    this.unOutLineColor = const Color(0xffacacac),
    this.radius = 4,
    this.fontColor = const Color(0xffab4bf4),
    this.unFontColor = const Color(0xffacacac),
    this.fontSize = 12,
    this.mainAxisExtent = 50,
    this.itemAlignment,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.decoration,
    this.color,
    this.border,
  }) : super(key: key);

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: Container(
          decoration: widget.decoration ?? BoxDecoration(color: widget.color),
          margin: widget.margin,
          padding: widget.padding ??
              const EdgeInsetsDirectional.only(start: 15,end:15,bottom: 5, top: 10),
          child: Stack(
            children: [
              Container(
                margin: widget.choose == Choose.multi
                    ? const EdgeInsetsDirectional.only(bottom: 44)
                    : null,
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //设置列数
                      crossAxisCount: widget.crossAxisCount,
                      //设置横向间距
                      crossAxisSpacing: widget.crossAxisSpacing,
                      //设置主轴间距
                      mainAxisSpacing: widget.mainAxisSpacing,
                      // 宽高比
                      // childAspectRatio: 3.3,
                      mainAxisExtent: widget.mainAxisExtent),
                  itemBuilder: (context, index) {
                    return widget.choose == Choose.single
                        ? InkWell(
                            child: Container(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 4, end: 4),
                                decoration: BoxDecoration(
                                    color: widget.filterList[index].isSelect == true
                                        ? widget.bgColor
                                        : widget.unBgColor,
                                    borderRadius: widget.border != null
                                        ? null
                                        : BorderRadius.all(
                                            Radius.circular(widget.radius)),
                                    border: widget.border ??
                                        Border.all(
                                            color: widget.filterList[index].isSelect == true
                                                ? widget.outLineColor
                                                : widget.unOutLineColor)),
                                alignment:
                                    widget.itemAlignment ?? Alignment.center,
                                child: Text(widget.filterList[index].name ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: widget.fontSize,
                                        color: widget.filterList[index].isSelect == true ? widget.fontColor : widget.unFontColor))),
                            onTap: () {
                              if (widget.filterList[index].isSelect) {
                                // widget.menuController.changeTitle(
                                //     widget.index, '');

                                return;
                              }
                              widget.menuController.changeTitle(
                                  widget.index, widget.filterList[index].name);
                              setState(() {
                                for (int i = 0;
                                    i < widget.filterList.length;
                                    i++) {
                                  if (i == index) {
                                    widget.filterList[i].isSelect = true;
                                  } else {
                                    widget.filterList[i].isSelect = false;
                                  }
                                }
                              });
                              if (widget.onTap != null) widget.onTap!(index);
                            })
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    child: Text(
                                        widget.filterList[index].name ?? "",
                                        style: TextStyle(
                                            color: widget.filterList[index]
                                                        .isSelect ==
                                                    true
                                                ? widget.fontColor
                                                : widget.unFontColor)),
                                    onTap: () {
                                      setState(() {
                                        widget.filterList[index].isSelect =
                                            !(widget
                                                .filterList[index].isSelect);
                                      });
                                    },
                                  )),
                                  SizedBox(
                                    height: 20,
                                    child: Checkbox(
                                      value: widget.filterList[index].isSelect,
                                      onChanged: (v) {
                                        setState(() {
                                          widget.filterList[index].isSelect =
                                              !(widget
                                                  .filterList[index].isSelect);
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                  },
                  itemCount: widget.filterList.length,
                ),
              ),
              Visibility(
                child: Positioned(
                  child: SizedBox(
                    height: 44,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 102,
                          child: ElevatedButton(
                            child: const Text("重置"),
                            onPressed: () {
                              setState(() {
                                for (var data in widget.filterList) {
                                  data.isSelect = false;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 229,
                          child: ElevatedButton(
                            child: const Text("确定"),
                            onPressed: () {
                              String title = "";

                              for (var data in widget.filterList) {
                                if (data.isSelect == true) {
                                  title += "${data.name},";
                                }
                              }

                              widget.menuController
                                  .changeTitle(widget.index, title);
                              if (widget.onTap != null) widget.onTap!(0);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: 0,
                  left: 0,
                  right: 0,
                ),
                visible: widget.choose == Choose.multi,
              )
            ],
          )),
      removeTop: true,
    );
  }
}
