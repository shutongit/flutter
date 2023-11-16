import 'package:flutter/material.dart';
import 'package:material_app/widget/m_list.dart';
import 'package:material_app/page/app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  List list = const [
    MList(
        title: '应用栏',
        description: '显示与当前屏幕有关的信息和操作',
        icon: Icon(Icons.view_comfortable_rounded))
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
                MaterialPageRoute(builder: (context) => const AppBarDemo()),
              )
            },
            child: Container(
                color: const Color.fromARGB(247, 201, 242, 232),
                padding: const EdgeInsets.symmetric(vertical: 5),
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
    return Row(children: [
      Padding(
        padding: const EdgeInsets.all(5),
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
    ]);
  }
}
