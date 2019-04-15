
import 'package:flutter/material.dart' show Color, Brightness;

Brightness colorBrightness(Color color) {
	if (color != null) {
		if (color.red * 0.2126 + color.green * 0.7152 + color.blue * 0.0722 >= 0.179) {
		// if (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114 >= 127.5) {
			return Brightness.light;
		} else {
			return Brightness.dark;
		}
	}
	return null;
}

bool isLight(Color color) {
	return !isDark(color);
}

bool isDark(Color color) {
	return color.computeLuminance() < 0.179;
}