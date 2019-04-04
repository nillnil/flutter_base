
import 'package:flutter/material.dart' show Color, Brightness;

Brightness colorBrightness(Color color) {
	if (color != null) {
		if (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114 >= 127.5) {
//		if (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114 >= 192) {
//		if (color.red * 0.2627 + color.green * 0.678 + color.blue * 0.0593 >= 192) {
//		if (color.red * 0.213 + color.green * 0.715 + color.blue * 0.072 >= 192) {
//		if (color.red * 0.257 + color.green * 0.504 + color.blue * 0.098 + 16 >= 192) {
//		if (color.red * 0.183 + color.green * 0.614 + color.blue * 0.062 + 16 >= 192) {
//		if (1 - (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114) / 255 >= .5) {
			return Brightness.light;
		} else {
			return Brightness.dark;
		}
	}
	return null;
}

bool isLight(Color color) {
	Brightness brightness = colorBrightness(color);
	if (brightness != null && brightness == Brightness.light) {
		return true;
	} else {
		return false;
	}
}

bool isDark(Color color) {
	return !isDark(color);
}