import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.function,
  });
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: function,
        child: const Icon(
          Icons.download_outlined,
          color: Color(0xff61FD5E),
        ),
      ),
    );
  }
}
