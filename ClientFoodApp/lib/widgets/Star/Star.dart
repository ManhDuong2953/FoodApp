import 'package:flutter/material.dart';

class StarRate extends StatelessWidget {
  final double? rate;

  const StarRate({Key? key, this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Icon(
            (i < (rate ?? 0.0).round()) ? Icons.star : Icons.star_border,
            color: (i < (rate ?? 0.0).round())
                ? ((rate ?? 0.0) - i >= 0.5)
                    ? Colors.red
                    : const Color.fromARGB(255, 255, 88, 88)
                : Colors.red,
            size: 16,
          ),
      ],
    );
  }
}
