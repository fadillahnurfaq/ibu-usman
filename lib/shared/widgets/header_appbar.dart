import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget {
  const HeaderAppBar({
    super.key,
    required this.label,
    required this.hide,
  });
  final String label;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      padding: hide == false
          ? const EdgeInsets.fromLTRB(0, 15, 0, 0)
          : const EdgeInsets.fromLTRB(0, 25, 0, 0),
      child: Row(
        mainAxisAlignment: hide == false
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          if (hide == false)
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          if (hide == false)
            const SizedBox(
              width: 42,
            ),
        ],
      ),
    );
  }
}
