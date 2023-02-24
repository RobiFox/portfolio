import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:robi_portfolio/data.dart';
import 'package:robi_portfolio/pages/pages.dart';
import 'package:robi_portfolio/string_apis.dart';

import 'widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  {
    String tagsData = await rootBundle.loadString(
        "data/tags.json".asAsset());
    List<dynamic> tagsJson = jsonDecode(tagsData);
    for (var v in tagsJson) {
      Data.tags[v["id"]] = Tag.fromJson(v);
    }
  }
  {
    String projectsData = await rootBundle.loadString(
        "data/projects.json".asAsset());
    List<dynamic> projectsJson = jsonDecode(projectsData);
    for (var v in projectsJson) {
      Data.projects.add(ProjectData.fromJson(v));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: ListView(
      controller: _scrollController,
      children: [HomePage(scrollController: _scrollController,), ProjectsPage()],
    ));
  }
}
