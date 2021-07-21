import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'provider/app_provider.dart';

const String _version = '2.2.2+2-pre';
const String _flutter_version = '2.2.2';

const double _appBarMaxHeight = 100;

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
      body: Consumer<AppProvider>(
        builder: (_, AppProvider appProvider, __) {
          return ListView(
            children: const <Widget>[
              _PlatformWidget(),
              _CustomSettingWidget(),
              _VersionWidget(),
              _DocWidget(),
            ],
          );
        },
      ),
      baseParam: BaseParam(
        cupertino: const <String, dynamic>{
          'backgroundColor': CupertinoColors.systemGroupedBackground,
        },
      ),
    );
  }
}

class _DocWidget extends StatelessWidget {
  const _DocWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSection(
      margin: const EdgeInsets.only(top: 20.0),
      children: <Widget>[
        BaseTile(
          title: const Center(
            child: Text('查看文档'),
          ),
          onTap: () async {
            const String url = 'https://nillnil.github.io/flutter_base/#/';
            if (await canLaunch(url)) {
              launch(url);
            }
          },
        ),
      ],
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

class _CustomSettingWidget extends StatelessWidget {
  const _CustomSettingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSection(
      margin: const EdgeInsets.only(top: 20.0),
      children: <Widget>[
        const _NightModeWidget(),
        BaseTile(
          titleText: '个性化设置',
          trailing: const BaseIcon(
            icon: CupertinoIcons.right_chevron,
            size: 25,
            color: Colors.grey,
          ),
          onTap: () {
            BaseRoute<void>(
              builder: (_) {
                return const _OtherSettingWidget();
              },
              fullscreenGackGesture: false,
            ).push(context);
          },
        ),
      ],
    );
  }
}

class _OtherSettingWidget extends StatelessWidget {
  const _OtherSettingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(title: Text('个性化设置')),
      body: Consumer<AppProvider>(
        builder: (BuildContext context, AppProvider appProvider, _) {
          return ListView(
            children: <Widget>[
              const SizedBox(height: 20),
              BaseMaterialWidget.withoutSplash(
                theme: BaseTheme.of(context).materialTheme,
                child: ExpansionTile(
                  title: const Text('导航栏默认高度'),
                  childrenPadding: const EdgeInsets.all(10.0),
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text('${appProvider.appBarHeight!.toInt()}'),
                          ),
                          Row(
                            children: <Widget>[
                              const Text('0'),
                              Expanded(
                                child: BaseSlider(
                                  value: appProvider.appBarHeight != null
                                      ? appProvider.appBarHeight!
                                      : isCupertinoMode
                                          ? 44.0
                                          : 56.0,
                                  min: 0.0,
                                  divisions: (_appBarMaxHeight - 0) ~/ 2,
                                  max: _appBarMaxHeight,
                                  onChanged: (double value) {
                                    appProvider.changeAppBarHeight(value);
                                  },
                                ),
                              ),
                              Text('${_appBarMaxHeight.toInt()}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              BaseTile(
                titleText: '路由全屏手势返回',
                trailing: BaseSwitch(
                  value: appProvider.routeFullscreenGackGesture,
                  onChanged: (bool value) {
                    if (value) {
                      const BaseAlertDialog(
                        title: Text('启动全屏手势返回\n请自行解决手势冲突页面'),
                      ).show<void>(context);
                    }
                    appProvider.changeRouteFullscreenGackGesture();
                  },
                ),
                onTap: () {},
              ),
            ],
          );
        },
      ),
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
        return BaseTile(
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
                    trailing: appProvider.themeMode == ThemeMode.system ? trailing : blankWidget,
                    onTap: () {
                      appProvider.changeThemeMode(ThemeMode.system);
                    },
                  ),
                  BaseTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    title: const Text('深色'),
                    trailing: appProvider.themeMode == ThemeMode.dark ? trailing : blankWidget,
                    onTap: () {
                      appProvider.changeThemeMode(ThemeMode.dark);
                    },
                  ),
                  BaseTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    title: const Text('浅色'),
                    trailing: appProvider.themeMode == ThemeMode.light ? trailing : blankWidget,
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
      baseParam: BaseParam(
        cupertino: const <String, dynamic>{
          'backgroundColor': CupertinoColors.systemGroupedBackground,
        },
      ),
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
                value: currentBaseMode != defaultBaseMode,
                onChanged: (_) {
                  BasePlatformMode? platformMode = appProvider.platformMode;
                  platformMode = platformMode?.changePlatformMode(mode: currentBaseMode == BaseMode.cupertino ? BaseMode.material : BaseMode.cupertino);
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
