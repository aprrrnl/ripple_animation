import 'package:flutter/material.dart';
import 'package:rippleanimation/circle_painter.dart';
import 'package:rippleanimation/curve_wave.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ripple Animation',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  final amountController = TextEditingController();
  final whatsappController = TextEditingController();
  final double size = 80.0;
  final Color color = Colors.blue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[color, Color.lerp(color, Colors.white, .05)!],
            ),
          ),
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: const CurveWave(),
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), padding: const EdgeInsets.all(30)),
              child: const Icon(
                Icons.add,
                size: 70,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ripple Animation',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Center(
        child: CustomPaint(
          painter: CirclePainter(
            _controller,
            color: color,
          ),
          child: SizedBox(
            width: size * 4.125,
            height: size * 4.125,
            child: _button(),
          ),
        ),
      ),
    );
  }
}
