import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double _borderRadius = 32;

class Tag extends StatefulWidget {
  final String name;
  final Color color;
  final Widget? child;
  final Function? onTap;

  const Tag({Key? key, required this.name, required this.color, this.child, this.onTap})
      : super(key: key);

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
      onTap: widget.onTap?.call(),
      child: Ink(
        height: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
            color: widget.color),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.name, style: GoogleFonts.roboto(color: Colors.white), textAlign: TextAlign.center,),
              if (widget.child != null) Row(
                children: [
                  const SizedBox(width: 4),
                  widget.child!,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
