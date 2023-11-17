import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomAppBarDemo extends StatefulWidget {
  const BottomAppBarDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BottomAppBarDemoState();
  }
}

class _BottomAppBarDemoState extends State<BottomAppBarDemo>
    with RestorationMixin {
  final RestorableBool _showFab = RestorableBool(true);
  final RestorableBool _showNotch = RestorableBool(true);
  final RestorableInt _currentFabLocation = RestorableInt(0);

  static const List<FloatingActionButtonLocation> _fabLocations = [
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  String? get restorationId => 'bottom_app_bar_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_showFab, 'show_fab');
    registerForRestoration(_showNotch, 'show_notch');
    registerForRestoration(_currentFabLocation, 'current_fab_location');
  }

  @override
  void dispose() {
    _showFab.dispose();
    _showNotch.dispose();
    _currentFabLocation.dispose();
    super.dispose();
  }

  /// 点击悬浮操作按钮
  void _onShowFabChanged(bool value) {
    setState(() {
      _showFab.value = value;
    });
  }

  /// 点击凹口
  void _onShowNotchChanged(bool value) {
    setState(() {
      _showNotch.value = value;
    });
  }

  /// 切换悬浮按钮的位置
  void _onFabLocationChanged(int? value) {
    setState(() {
      _currentFabLocation.value = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('底部应用栏'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 88),
        children: [
          SwitchListTile(
            title: const Text('悬浮操作按钮'),
            value: _showFab.value,
            onChanged: _onShowFabChanged,
          ),
          SwitchListTile(
            title: const Text('凹口'),
            value: _showNotch.value,
            onChanged: _onShowNotchChanged,
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('悬浮操作按钮位置'),
          ),
          RadioListTile(
            title: const Text('停靠 - 末端'),
            value: 0,
            groupValue: _currentFabLocation.value,
            onChanged: _onFabLocationChanged,
          ),
          RadioListTile(
            title: const Text('停靠 - 居中'),
            value: 1,
            groupValue: _currentFabLocation.value,
            onChanged: _onFabLocationChanged,
          ),
          RadioListTile(
            title: const Text('悬浮 - 末端'),
            value: 2,
            groupValue: _currentFabLocation.value,
            onChanged: _onFabLocationChanged,
          ),
          RadioListTile(
            title: const Text('悬浮 - 居中'),
            value: 3,
            groupValue: _currentFabLocation.value,
            onChanged: _onFabLocationChanged,
          ),
        ],
      ),
      floatingActionButton: _showFab.value
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // border: Border.all(color: const Color(0xff000000), width: 1),
                color: Colors.red,
              ),
              child: Semantics(
                container: true,
                sortKey: const OrdinalSortKey(0),
                child: CupertinoButton(
                  onPressed: () {},
                  // tooltip: '创建',
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: _fabLocations[_currentFabLocation.value],
      bottomNavigationBar: _DemoBottomAppBar(
        fabLocation: _fabLocations[_currentFabLocation.value],
        shape: _showNotch.value ? const CircularNotchedRectangle() : null,
      ),
    );
  }
}

class _DemoBottomAppBar extends StatelessWidget {
  const _DemoBottomAppBar({required this.fabLocation, this.shape});
  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final centerLocations = <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return Semantics(
      sortKey: const OrdinalSortKey(1),
      container: true,
      label: '底部应用栏',
      child: BottomAppBar(
        shape: shape,
        child: IconTheme(
          data: IconThemeData(
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
                tooltip: '打开导航菜单',
              ),
              if (centerLocations.contains(fabLocation)) const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                tooltip: '搜索',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
                tooltip: '收藏',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
