import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tag extends StatefulWidget {
  final String name;
  final Color color;
  final Widget? child;

  const Tag({Key? key, required this.name, required this.color, this.child})
      : super(key: key);

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          color: widget.color),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.name, style: GoogleFonts.roboto(color: Colors.white),),
            if (widget.child != null) widget.child!
          ],
        ),
      ),
    );
  }
}
