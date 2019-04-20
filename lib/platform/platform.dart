import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;

TargetPlatform basePlatform = defaultTargetPlatform;
bool withoutSplashOnCupertino = true;

setPlatform({
  TargetPlatform targetPlatform,
  bool withoutSplashOnCupertino,
}) {
  basePlatform = targetPlatform ?? defaultTargetPlatform;
  withoutSplashOnCupertino = withoutSplashOnCupertino;
}

@deprecated
void changePlatform() {
  if (basePlatform == TargetPlatform.iOS) {
    changeToMaterial();
  } else if (basePlatform == TargetPlatform.android ||
      basePlatform == TargetPlatform.fuchsia) {
    changeToCupertino();
  } else {
    print('The platform is = $basePlatform, it not support yet.');
  }
}

@deprecated
void changeToCupertino() {
  basePlatform = TargetPlatform.iOS;
}

@deprecated
void changeToMaterial() {
  basePlatform = TargetPlatform.android;
}

/// 使用Cupertino模式构建
bool get useCupertino => basePlatform != null
    ? basePlatform == TargetPlatform.iOS
    : defaultTargetPlatform == TargetPlatform.iOS;

/// 使用Material模式构建
bool get useMaterial => basePlatform != null
    ? (basePlatform == TargetPlatform.android ||
        basePlatform == TargetPlatform.fuchsia)
    : (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.fuchsia);
