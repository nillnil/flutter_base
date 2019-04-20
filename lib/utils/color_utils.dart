
import 'dart:math';
import 'dart:ui';

bool isLight(Color color) {
	return !isDark(color);
}

bool isDark(Color color) {
	return color.computeLuminance() < 0.179;
}

class RandomColor {

	final Color color;

	RandomColor({
		int red,
		int blue,
		int green,
		double opacity,
		int alpha,
	}) : assert(opacity == null || alpha == null, 'Cannot provide both a opacity and a alpha! '),
			color = (opacity == null && alpha == null) ? Color.fromRGBO(
				red ?? Random().nextInt(256),
				green ?? Random().nextInt(256),
				blue ?? Random().nextInt(256),
				1,
			): (
				opacity != null ? Color.fromRGBO(
					red ?? Random().nextInt(256),
					green ?? Random().nextInt(256),
					blue ?? Random().nextInt(256),
					opacity ?? Random().nextDouble(),
				) : Color.fromARGB(
					alpha ?? Random().nextInt(256),
					red ?? Random().nextInt(256),
					green ?? Random().nextInt(256),
					blue ?? Random().nextInt(256),
				)
			);

	Color withOpacity({ double opacity = 1.0 }) {
		assert(opacity >= 0.0 && opacity <= 1.0);
		return Color.fromRGBO(red, green, blue, opacity);
	}

	Color withAlpha({ int alpha = 255 }) {
		return Color.fromARGB(alpha, red, green, blue);
	}

	int get red => color.red;

	int get green => color.green;

	int get blue => color.blue;

	double get opacity => color.opacity;

	int get alpha => color.alpha;

	int value({ bool withAlpha = true }) {
		if (withAlpha) {
			return ((((opacity * 0xff ~/ 1) & 0xff) << 24) |
			((red & 0xff) << 16) |
			((green & 0xff) << 8)  |
			((blue  & 0xff) << 0)) & 0xFFFFFFFF;
		}
		return (((red & 0xff) << 16) |
		((green & 0xff) << 8)  |
		((blue  & 0xff) << 0)) & 0xFFFFFFFF;
	}

  @override
	String toString({ bool withAlpha = true }) {
		String _redStr = red.toRadixString(16);
		String _greenStr = green.toRadixString(16);
		String _blueStr = blue.toRadixString(16);
		String _alphaStr = color.alpha.toRadixString(16);
		if (red < 10) {
			_redStr = '0$red';
		}
		if (green < 10) {
			_greenStr = '0$green';
		}
		if (blue < 10) {
			_blueStr = '0$blue';
		}
		if (withAlpha) {
			if (color.alpha < 10) {
				_alphaStr = '0$_alphaStr}';
			}
			return '$_alphaStr$_redStr$_greenStr$_blueStr';
		}
		return '$_redStr$_greenStr$_blueStr';
	}

}