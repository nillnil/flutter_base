import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;

TargetPlatform basePlatform = defaultTargetPlatform;
bool withoutSplashOnCupertino = true;

/// set the platform
void setPlatform({
  TargetPlatform targetPlatform,
  bool withoutSplashOnCupertino = true,
}) {
  basePlatform = targetPlatform ?? defaultTargetPlatform;
  withoutSplashOnCupertino = withoutSplashOnCupertino;
}

/// build by Cupertino
bool get useCupertino => basePlatform != null
    ? basePlatform == TargetPlatform.iOS
    : defaultTargetPlatform == TargetPlatform.iOS;

/// build by Material
bool get useMaterial => basePlatform != null
    ? (basePlatform == TargetPlatform.android ||
        basePlatform == TargetPlatform.fuchsia)
    : (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.fuchsia);
