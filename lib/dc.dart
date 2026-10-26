import 'package:flutter/material.dart';

class DragCircleScreen extends StatefulWidget {
  const DragCircleScreen({super.key});

  @override
  State<DragCircleScreen> createState() => _DragCircleScreenState();
}

class _DragCircleScreenState extends State<DragCircleScreen> {
  static const double circleSize = 80;

  Offset? position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Устанавливаем круг по центру при первом запуске.
          position ??= Offset(
            (constraints.maxWidth - circleSize) / 2,
            (constraints.maxHeight - circleSize) / 2,
          );

          final maxX =
              (constraints.maxWidth - circleSize).clamp(0.0, double.infinity);

          final maxY =
              (constraints.maxHeight - circleSize).clamp(0.0, double.infinity);

          return Stack(
            children: [
              Positioned(
                left: position!.dx,
                top: position!.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      position = Offset(
                        (position!.dx + details.delta.dx).clamp(0.0, maxX),
                        (position!.dy + details.delta.dy).clamp(0.0, maxY),
                      );
                    });
                  },
                  child: Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}