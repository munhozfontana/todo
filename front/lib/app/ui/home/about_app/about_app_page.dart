import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Spacer(flex: 2),
            CircleAvatar(
              maxRadius: 52,
              child: Icon(
                Icons.check_outlined,
                size: 52,
              ),
            ),
            Spacer(flex: 1),
            Text(
              'Todo List App',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Spacer(flex: 1),
            Text(
              """This app have the objective to show how to organize your tasks""",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
