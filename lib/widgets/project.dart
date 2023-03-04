import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robi_portfolio/data.dart';
import 'package:robi_portfolio/string_apis.dart';
import 'widgets.dart';
import 'package:url_launcher/url_launcher.dart';

const double _nameFontSize = 42;
const double _descriptionFontSize = 14;
Map<String, Image> icons = {
  "github.com": Image.asset(
    "icons/github-mark.png".asAsset(),
    isAntiAlias: true,
    filterQuality: FilterQuality.medium,
  ),
  "gamejolt.com": Image.asset(
    "icons/gamejolt.png".asAsset(),
    isAntiAlias: true,
    filterQuality: FilterQuality.medium,
  ),
  "youtube.com": Image.asset(
    "icons/youtube.png".asAsset(),
    isAntiAlias: true,
    filterQuality: FilterQuality.medium,
  ),
};

class Project extends StatelessWidget {
  final ProjectData data;

  const Project({Key? key, required this.data}) : super(key: key);

  List<Widget> _buildLinkButtons() {
    List<Widget> buttons = [];
    for (String link in data.links!) {
      Uri uri = Uri.parse(link);
      buttons.add(IconButton(
          iconSize: 48,
          onPressed: () => launchUrl(uri),
          icon: icons[uri.host] ?? const Icon(Icons.link)));
    }
    return buttons;
  }

  Widget _buildImage(BuildContext context, double width, double height) {
    return MouseRegion(
      cursor: SystemMouseCursors.zoomIn,
      child: GestureDetector(
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
                              parent: animation, curve: Curves.fastOutSlowIn)),
                      child: child,
                    );
                  },
                  child: Align(
                      child: Hero(
                          tag: "zoom",
                          child: Stack(alignment: Alignment.center, children: [
                            GestureDetector(
                              child: Container(
                                  color: Colors.black.withOpacity(0.9)),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Container(
                                constraints: BoxConstraints(
                                    maxWidth: width / 1.2,
                                    maxHeight: height / 1.2),
                                child: Image.asset("projects/${data.image}")),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                          color: Colors.white,
                                          iconSize: 64,
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          icon: const Icon(Icons.arrow_back)),
                                    ))),
                          ]))));
            },
          ));
        },
        child: SizedBox(
          height: 192,
          width: 256,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "projects/${data.image}".asAsset(),
              fit: BoxFit.cover,
              isAntiAlias: true,
              filterQuality: FilterQuality.medium,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: max(width / 2, 800) - 16,
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(16),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(width: 4, color: Colors.transparent)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context, width, height),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: SizedBox(
                height: 192,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            data.name,
                            style: GoogleFonts.roboto(fontSize: _nameFontSize),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Transform.translate(
                          offset: const Offset(0, -8),
                          child: IntrinsicWidth(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: Ink(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(32)),
                                )),
                                Row(children: _buildLinkButtons()),
                              ],
                            ),
                          ),
                        )
                      ],
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
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Stack(
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
                          ),
                        ),
                      ),
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
  final List<String>? links;

  ProjectData(this.name, this.description, this.tags, this.image, this.links);

  ProjectData.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        description = json["description"],
        image = json["image"],
        tags = (json["tags"] as List<dynamic>)
            .map((e) => Data.tags[e])
            .cast<Tag>()
            .toList(),
        links = (json["links"] as List<dynamic>).cast<String>().toList();

  ProjectData withTags({List<Tag>? tags}) {
    return ProjectData(name, description, tags ?? this.tags, image, links);
  }
}
