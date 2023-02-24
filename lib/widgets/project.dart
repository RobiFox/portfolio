import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robi_portfolio/data.dart';
import 'package:robi_portfolio/string_apis.dart';
import 'widgets.dart';

const double _nameFontSize = 24;
const double _descriptionFontSize = 14;

class Project extends StatelessWidget {
  final ProjectData data;

  const Project({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: max(width / 2, 800) - 16,
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(12),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(width: 4, color: Colors.transparent)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: SizedBox(
                height: 128,
                width: 256,
                child: Image.asset("projects/${data.image}".asAsset(),
                    fit: BoxFit.contain),
              ),
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  barrierDismissible: true,
                  transitionDuration: const Duration(milliseconds: 300),
                  reverseTransitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AnimatedBuilder(
                        animation: animation,
                        builder: (BuildContext context, Widget? child) {
                          return FadeTransition(
                            opacity: Tween(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.fastOutSlowIn)),
                            child: child,
                          );
                        },
                        child: Align(
                            child: Hero(
                                tag: "zoom",
                                child: Stack(alignment: Alignment.center, children: [
                                  GestureDetector(child: Container(color: Colors.black.withOpacity(0.9)),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },),
                                  Image.asset("projects/${data.image}")
                                ]))));
                  },
                ));
              },
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: SizedBox(
                height: 128,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.name,
                      style: GoogleFonts.roboto(fontSize: _nameFontSize),
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final maxLines = max(
                              (constraints.maxHeight / _descriptionFontSize)
                                      .floor() -
                                  1,
                              1);
                          return Text(
                            data.description,
                            style: GoogleFonts.roboto(
                                fontSize: _descriptionFontSize),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: maxLines,
                          );
                        },
                      ),
                    ),
                    if (data.tags != null)
                      Stack(
                        children: [
                          Positioned.fill(
                              left: -8,
                              right: -8,
                              top: -8,
                              bottom: -8,
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.grey.withAlpha(12),
                                  //backgroundBlendMode: BlendMode.b
                                ),
                              )),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: data.tags!,
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectData {
  final String name;
  final String description;
  final String image;
  final List<Tag>? tags;

  ProjectData(this.name, this.description, this.tags, this.image);

  ProjectData.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        description = json["description"],
        image = json["image"],
        tags = (json["tags"] as List<dynamic>)
            .map((e) => Data.tags[e])
            .cast<Tag>()
            .toList();

  ProjectData withTags({List<Tag>? tags}) {
    return ProjectData(name, description, tags ?? this.tags, image);
  }
}
