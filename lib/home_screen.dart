import 'package:flutter/material.dart';

import 'custom_button.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                height: 70,
                width: 250,
                color: Colors.red,
                text: '1',
                onTap: () {},
                isAsync: true,
                circularProgressIndicator: const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
              CustomButton(
                height: 40,
                width: 100,
                color: Colors.blue,
                text: '2',
                onTap: () {},
              ),
              CustomButton(
                height: 70,
                width: 400,
                color: Colors.green,
                text: '3',
                disable: true,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
