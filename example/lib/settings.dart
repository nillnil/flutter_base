import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'provider/app_provider.dart';

const String _version = '2.2.2';
const String _flutter_version = '2.2.2';

const TextStyle _style = TextStyle(
  fontSize: 14.0,
);

class Settings extends StatelessWidget {
  const Settings({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: Text('设置'),
        transitionBetweenRoutes: true,
      ),
      safeAreaTop: true,
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: const <Widget>[
                  _PlatformWidget(),
                  _NightModeWidget(),
                  _VersionWidget(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  '使用 ',
                  style: _style,
                ),
                FlutterLogo(
                  size: 18.0,
                ),
                Text(
                  ' Flutter技术构建',
                  style: _style,
                ),
              ],
            ),
          ],
        ),
      ),
      cupertino: const <String, dynamic>{
        'backgroundColor': CupertinoColors.systemGroupedBackground,
      },
    );
  }
}

class _VersionWidget extends StatelessWidget {
  const _VersionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, _) {
        return const BaseSection(
          margin: EdgeInsets.only(top: 20.0),
          children: <Widget>[
            BaseTile(
              titleText: 'Flutter版本',
              trailing: Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Text(
                  _flutter_version,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            BaseTile(
              titleText: 'App版本',
              trailing: Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Text(
                  _version,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NightModeWidget extends StatelessWidget {
  const _NightModeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, _) {
        String themeModeText = '';
        switch (appProvider.themeMode) {
          case ThemeMode.light:
            themeModeText = '浅色';
            break;
          case ThemeMode.dark:
            themeModeText = '深色';
            break;
          default:
            themeModeText = '跟随系统';
        }
        return BaseSection(
          margin: const EdgeInsets.only(top: 20.0),
          children: <Widget>[
            BaseTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              title: const Text('外观'),
              trailing: SizedBox(
                width: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(themeModeText),
                    const BaseIcon(
                      icon: CupertinoIcons.right_chevron,
                      size: 25,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              onTap: () {
                BaseRoute<void>(
                  builder: (_) => _ThemeModePage(),
                  fullscreenDialog: true,
                ).push(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class _ThemeModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: const Text('外观'),
        padding: EdgeInsetsDirectional.zero,
        leading: BaseIconButton(
          icon: CupertinoIcons.clear_thick,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<AppProvider>(
        builder: (BuildContext context, AppProvider appProvider, _) {
          const Widget trailing = SizedBox(
            width: 40.0,
            child: BaseIcon(
              icon: CupertinoIcons.check_mark,
              size: 36,
            ),
          );
          const Widget blankWidget = SizedBox(
            width: 40.0,
          );
          return ListView(
            children: <Widget>[
              BaseSection(
                margin: const EdgeInsets.only(top: 0.0),
                children: <Widget>[
                  BaseTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    title: const Text('跟随系统'),
                    trailing: appProvider.themeMode == ThemeMode.system
                        ? trailing
                        : blankWidget,
                    onTap: () {
                      appProvider.changeThemeMode(ThemeMode.system);
                    },
                  ),
                  BaseTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    title: const Text('深色'),
                    trailing: appProvider.themeMode == ThemeMode.dark
                        ? trailing
                        : blankWidget,
                    onTap: () {
                      appProvider.changeThemeMode(ThemeMode.dark);
                    },
                  ),
                  BaseTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    title: const Text('浅色'),
                    trailing: appProvider.themeMode == ThemeMode.light
                        ? trailing
                        : blankWidget,
                    onTap: () {
                      appProvider.changeThemeMode(ThemeMode.light);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
      cupertino: const <String, dynamic>{
        'backgroundColor': CupertinoColors.systemGroupedBackground,
      },
    );
  }
}

class _PlatformWidget extends StatelessWidget {
  const _PlatformWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, _) {
        return BaseSection(
          margin: const EdgeInsets.only(top: 10.0),
          header: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '当前平台模式：${isCupertinoMode ? 'Cupertino' : 'Material'}',
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ),
          children: <Widget>[
            BaseTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              title: const Text('切换平台模式'),
              trailing: BaseSwitch(
                value: currentPlatformMode != defaultPlatformMode,
                onChanged: (_) {
                  BasePlatformMode? platformMode = appProvider.platformMode;
                  platformMode = platformMode?.changePlatformMode(
                      mode: currentPlatformMode == BaseMode.cupertino
                          ? BaseMode.material
                          : BaseMode.cupertino);

                  appProvider.changePlatformMode(platformMode);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
