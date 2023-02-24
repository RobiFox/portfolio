import 'package:flutter/material.dart';

class Project extends StatelessWidget {
  final ProjectData data;

  const Project({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [
      Text(data.name),
      Text(data.description),
    ],),);
  }
}

class ProjectData {
  final String name;
  final String description;

  ProjectData(this.name, this.description);
}
