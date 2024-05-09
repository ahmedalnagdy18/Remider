import 'package:flutter/material.dart';

class FloatingWidget extends StatelessWidget {
  const FloatingWidget({super.key, required this.onPressed,required this.icon});
final void Function()? onPressed;
final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            backgroundColor: Colors.pink[100],
            tooltip: 'Add Task',
            elevation: 4.0,
            onPressed: onPressed,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child:  Icon(
                icon,
                size: 24,
              ),
            ),
          ),
        );
  }
}