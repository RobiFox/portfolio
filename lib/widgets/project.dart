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
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.black.withAlpha(10), width: 4)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 128,
              child: Image.asset("icons/github-mark.png".asAsset(),
                  fit: BoxFit.contain),
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
                          final maxLines =
                              (constraints.maxHeight / _descriptionFontSize)
                                      .floor() -
                                  1;
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
                    const SizedBox(
                      height: 8,
                    ),
                    if (data.tags != null)
                      Row(
                        children: [
                          for (var tag in data.tags!)
                            Row(
                              children: [tag, const SizedBox(width: 8)],
                            )
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
  final List<Tag>? tags;

  ProjectData(this.name, this.description, this.tags);

  ProjectData.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        description = json["description"],
        tags = (json["tags"] as List<dynamic>).map((e) => Data.tags[e]).cast<Tag>().toList();

  ProjectData withTags({List<Tag>? tags}) {
    return ProjectData(name, description, tags ?? this.tags);
  }
}
