import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggletheme(bool islight) {
    setState(() {
      _themeMode = islight ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: FadingTextAnimation(toggletheme: toggletheme),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final Function(bool) toggletheme;
  FadingTextAnimation({required this.toggletheme});

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  Color textcolor = Colors.black;
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void pickcolor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: textcolor,
            onColorChanged: (color) {
              setState(() {
                textcolor = color;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            child: Text('Enter'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          IconButton(
            icon: Icon(Icons.light_mode),
            onPressed: () => widget.toggletheme(true),
          ),
          IconButton(
            icon: Icon(Icons.dark_mode),
            onPressed: () => widget.toggletheme(false),
          ),
          IconButton(
            icon: Icon(Icons.palette),
            onPressed: pickcolor,
          ),
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24, color: textcolor),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
