import 'package:flutter/material.dart';

/// 菜单控制器
class MenuController extends ChangeNotifier {
  // 当前组件是否显示 默认不显示
  bool isShow = false;

  // 显示当前组件title的文本
  String title = "";

  // 显示哪个组件 默认第一个
  int index = 0;

  // 选择组件的title
  int titleIndex = 0;

  /// 更改Title
  changeTitle(int titleIndex, String? title) {
    this.titleIndex = titleIndex;
    this.title = title ?? "";
    hide();
  }

  // 显示 下拉
  show(int index) {
    this.index = index;
    if (!isShow) {
      isShow = true;
    }
    notifyListeners();
  }

  // 隐藏 取消
  hide() {
    isShow = false;
    notifyListeners();
  }
}
