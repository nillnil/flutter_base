import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

enum AppPlatform {
	iOS,
	android,
	linux,
	macOS,
	windows,
	fuchsia,
	none
}

AppPlatform appPlatform;

setPlatform({ AppPlatform platform }) {
	appPlatform = platform != null ? platform
		: Platform.isIOS ? AppPlatform.iOS
		: Platform.isAndroid ? AppPlatform.android
		: Platform.isFuchsia ? AppPlatform.fuchsia
		: Platform.isWindows ? AppPlatform.windows
		: Platform.isLinux ? AppPlatform.linux
		: Platform.isMacOS ? AppPlatform.macOS
		: AppPlatform.none;
}

void changePlatform() {
	if (appPlatform == AppPlatform.iOS) {
		changeToMaterial();
	} else if (appPlatform == AppPlatform.android || appPlatform == AppPlatform.fuchsia) {
		changeToCupertino();
	} else {
		print('Still not supporting the platform yet. ');
	}
}

void changeToCupertino() {
	appPlatform = AppPlatform.iOS;
}

void changeToMaterial() {
	appPlatform = AppPlatform.android;
}

bool get isCupertino {
	if (appPlatform == null) {
		return debugDefaultTargetPlatformOverride != null ? debugDefaultTargetPlatformOverride == TargetPlatform.iOS
			: defaultTargetPlatform == TargetPlatform.iOS;
	} else {
		return appPlatform == AppPlatform.iOS || appPlatform == AppPlatform.macOS;
	}
}

bool get isMaterial {
	if (appPlatform == null) {
		return debugDefaultTargetPlatformOverride != null ? debugDefaultTargetPlatformOverride == TargetPlatform.android
			: (defaultTargetPlatform == TargetPlatform.android ||
			defaultTargetPlatform == TargetPlatform.fuchsia);
	} else {
		return appPlatform == AppPlatform.android
			|| appPlatform == AppPlatform.fuchsia
			|| appPlatform == AppPlatform.windows
			|| appPlatform == AppPlatform.linux;
	}
}
