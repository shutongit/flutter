import 'package:flutter/material.dart';

enum BannerDemoAction {
  reset,
  showMultipleActions,
  showLeading,
}

class BannerDemo extends StatefulWidget {
  const BannerDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BannerDemoState();
  }
}

class _BannerDemoState extends State<BannerDemo> {
  bool _displayBanner = true;
  bool _showMultipleActions = true;
  bool _showLeading = true;

  /// 下拉列表点击事件
  void handleDemoAction(BannerDemoAction action) {
    setState(() {
      switch (action) {
        case BannerDemoAction.reset:
          _displayBanner = true;
          _showMultipleActions = true;
          _showLeading = true;
          break;

        case BannerDemoAction.showMultipleActions:
          _showMultipleActions = !_showMultipleActions;
          break;

        case BannerDemoAction.showLeading:
          _showLeading = !_showLeading;
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final banner = MaterialBanner(
      content: const Text('您的密码已在其他设备上更新。请重新登录。'),
      leading: _showLeading
          ? CircleAvatar(
              backgroundColor: colorScheme.primary,
              child: Icon(
                Icons.access_alarm,
                color: colorScheme.onPrimary,
              ),
            )
          : null,
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              _displayBanner = false;
            });
          },
          child: const Text(
            '登录',
          ),
        ),
        if (_showMultipleActions)
          TextButton(
            onPressed: () {
              _displayBanner = false;
            },
            child: const Text('关闭'),
          ),
      ],
      backgroundColor: colorScheme.background,
    );

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text('横幅'),
        actions: [
          PopupMenuButton<BannerDemoAction>(
              onSelected: handleDemoAction,
              itemBuilder: (context) {
                return <PopupMenuEntry<BannerDemoAction>>[
                  const PopupMenuItem(
                    value: BannerDemoAction.reset,
                    child: Text('重置横幅'),
                  ),
                  const PopupMenuDivider(),
                  CheckedPopupMenuItem<BannerDemoAction>(
                    value: BannerDemoAction.showMultipleActions,
                    checked: _showMultipleActions,
                    child: const Text('多项操作'),
                  ),
                  CheckedPopupMenuItem<BannerDemoAction>(
                    value: BannerDemoAction.showLeading,
                    checked: _showLeading,
                    child: const Text('前置图标'),
                  ),
                ];
              })
        ],
      ),
      body: ListView.builder(
        restorationId: 'banner_demo_list_view',
        itemBuilder: (context, index) {
          if (index == 0 && _displayBanner) {
            return banner;
          }
          return ListTile(
            title: Text('项 $index'),
          );
        },
        itemCount: _displayBanner ? 21 : 20,
      ),
    );
  }
}
