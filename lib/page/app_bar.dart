import 'package:flutter/material.dart';

class AppBarDemo extends StatelessWidget {
  const AppBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text('打开导航栏'),
        actions: [
          IconButton(
            onPressed: () {
              print('favorite');
            },
            icon: const Icon(
              Icons.favorite,
              color: Color(0xffffffff),
            ),
          ),
          PopupMenuButton(
            tooltip: '显示菜单',
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('第一行'),
                ),
                const PopupMenuItem(child: Text('第二行')),
                const PopupMenuItem(child: Text('第三行')),
              ];
            },
            onSelected: (val) {
              print('val:$val');
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('首页'),
      ),
    );
  }
}
