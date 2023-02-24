import 'package:flutter/material.dart';

class TextMagnifierScreen extends StatelessWidget {
  const TextMagnifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Text Magnifier'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SelectableText('Magnifier'),
            TextField(
              controller: TextEditingController(text: 'Sample text'),
              magnifierConfiguration: TextMagnifierConfiguration(
                magnifierBuilder: (context, controller, magnifierInfo) {
                  return const RawMagnifier(
                    magnificationScale: 2,
                    focalPointOffset: Offset(0, 20),
                    size: Size(30, 40),
                  );
                },
              ),
              textDirection: TextDirection.ltr,
            ),
          ],
        ));
  }
}
