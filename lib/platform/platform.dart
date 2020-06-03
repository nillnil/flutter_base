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
    ? (basePlatform == TargetPlatform.iOS || basePlatform == TargetPlatform.macOS)
    : (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS);

/// build by Material
bool get useMaterial => !useCupertino;
