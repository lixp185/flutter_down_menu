import 'package:example/filter_res.dart';
import 'package:flutter/material.dart';
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
  final MenuController _menuController = MenuController();
  final List<FilterRes> list1 = [];
  final List<FilterRes> list2 = [];
  final List<FilterRes> list3 = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      list1.add(FilterRes(name: "选项$i"));
      list2.add(FilterRes(name: "选项2$i"));
      list3.add(FilterRes(name: "选项3$i"));
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
                titles: const ["检测领域", "业务类型", "距离"]),
            Expanded(
                child: DropDownMenu(
                    height: 300,
                    children: [
                      _searchFilter(list1, 0),
                      _searchFilter(list2, 1),
                      _searchFilter(list3, 2),
                    ],
                    menuController: _menuController))
          ],
        ));
  }

  Widget _searchFilter(List<FilterRes> filter, int i) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
      padding: const EdgeInsetsDirectional.only(bottom: 10),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //设置列数
          crossAxisCount: 3,
          //设置横向间距
          crossAxisSpacing: 10,
          //设置主轴间距
          mainAxisSpacing: 10,
          // 宽高比
          childAspectRatio: 3.3,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
                decoration: BoxDecoration(
                    color: filter[index].isSelect == true
                        ? const Color(0x0DAB4BF4)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    border: Border.all(
                        color: filter[index].isSelect == true
                            ? const Color(0xffab4bf4)
                            : const Color(0xffacacac))),
                alignment: Alignment.center,
                child: Text(filter[index].name ?? "",
                    style: TextStyle(
                        color: filter[index].isSelect == true
                            ? const Color(0xffab4bf4)
                            : const Color(0xffacacac)))),
            onTap: () {
              _menuController.changeTitle(i, filter[index].name);
              print(filter[index].name);
              setState(() {
                for (int i = 0; i < filter.length; i++) {
                  if (i == index) {
                    filter[i].isSelect = true;
                  } else {
                    filter[i].isSelect = false;
                  }
                }
              });
            },
          );
        },
        itemCount: filter.length,
      ),
    );
  }
}
