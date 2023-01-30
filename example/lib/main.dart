import 'package:flutter/material.dart';
import 'package:flutter_down_menu/flutter_down_menu.dart' as m;
import 'package:flutter_down_menu/flutter_down_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drown Menu Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Drown Menu '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final m.MenuController _menuController = m.MenuController();
  final List<FilterBean> list1 = [];
  final List<FilterBean> list2 = [];
  final List<FilterBean> list3 = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      list1.add(FilterBean(name: "选项$i"));
      list2.add(FilterBean(name: "选项2--$i"));
      list3.add(FilterBean(name: "选项3--$i"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            DropDownMenuHeader(
                menuController: _menuController,
                isAverage: true,
                titles: const ["检测领域", "业务类型", "距离"]),
            Expanded(
                child: Stack  (
              children: [
                InkWell(
                  child: Center(
                    child: Text(
                        "选择：item${_menuController.index}-- ${_menuController.title}"),
                    ),
                  onTap: () {},
                ),
                DropDownMenu(

                    heights: [
                      300,
                      200,
                      300
                    ],

                    milliseconds: 300,
                    children: [
                      MenuList(
                        index: 0,
                        choose: Choose.multi,
                        menuController: _menuController,
                        filterList: list1,
                        onTap: (index) {
                          setState(() {});
                        },
                      ),
                      MenuList(
                        index: 1,
                        menuController: _menuController,
                        filterList: list2,
                        crossAxisCount: 3,
                        padding: const EdgeInsetsDirectional.all(15),
                        outLineColor: Colors.transparent,
                        bgColor: Colors.transparent,
                        unBgColor: Colors.transparent,
                        unOutLineColor: Colors.transparent,
                        mainAxisExtent: 20,
                        color: Colors.white,
                        itemAlignment: Alignment.centerLeft,
                        onTap: (index) {
                          setState(() {});
                        },
                      ),
                      MenuList(
                        index: 2,
                        menuController: _menuController,
                        filterList: list3,
                        onTap: (index) {
                          setState(() {});
                        },
                      ),
                    ],
                    menuController: _menuController),
              ],
            ))
          ],
        ));
  }
}
