import 'package:flutter/material.dart';
import 'package:material_app/widget/m_list.dart';
import 'package:material_app/page/app_bar.dart';
import 'package:material_app/page/banner_demo.dart';
import 'package:material_app/page/bottom_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            tertiary: Colors.white,
            secondaryContainer: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Metrial Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List list = [
    const MList(
      title: '应用栏',
      description: '显示与当前屏幕有关的信息和操作',
      icon: Icon(Icons.view_comfortable_rounded),
      widget: AppBarDemo(),
    ),
    const MList(
      title: '横幅',
      description: '在列表内显示横幅',
      icon: Icon(Icons.view_kanban_outlined),
      widget: BannerDemo(),
    ),
    const MList(
      title: '底部应用栏',
      description: '在底部显示导航栏和几项操作',
      icon: Icon(Icons.book),
      widget: BottomAppBarDemo(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => list[index].widget),
              )
            },
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 201, 194, 194),
                    ),
                  ),
                ),
                child: ListItem(
                    icon: list[index].icon,
                    title: list[index].title,
                    descript: list[index]?.description)),
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key, required this.icon, required this.title, this.descript});
  final Icon icon;

  final String? title;
  final String? descript;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
          child: icon,
        ),
        Column(
          children: [
            Text(
              title ?? '',
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(descript ?? ''),
          ],
        ),
      ],
    );
  }
}
