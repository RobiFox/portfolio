import 'package:flutter/material.dart';
import 'package:robi_portfolio/data.dart';
import 'package:robi_portfolio/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late List<ProjectData> _shownProjects;

  @override
  void initState() {
    _shownProjects = Data.projects;
    super.initState();
  }

  Widget buildTagRemoveButton(BuildContext context) {
    return Transform.scale(
        scale: 2,
        child: FittedBox(
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.white,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: height),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            "Projects",
            style: GoogleFonts.roboto(
                fontSize: 64, decoration: TextDecoration.underline),
          ),
          const SizedBox(
            height: 8,
          ),
          for (var project in Data.projects)
            Column(
              children: [
                Project(
                  data: project,
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          /*Project(
              data: ProjectData("name",
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Faucibus et molestie ac feugiat. Blandit cursus risus at ultrices mi tempus imperdiet. Vulputate eu scelerisque felis imperdiet proin fermentum. Ornare quam viverra orci sagittis eu volutpat. Ultricies mi quis hendrerit dolor magna. Nulla at volutpat diam ut venenatis tellus in. Mattis pellentesque id nibh tortor id. Sit amet massa vitae tortor condimentum lacinia quis. Eros donec ac odio tempor orci dapibus ultrices in iaculis. Quis viverra nibh cras pulvinar mattis nunc sed blandit. Diam ut venenatis tellus in metus vulputate eu scelerisque felis. Purus semper eget duis at tellus. Diam in arcu cursus euismod quis viverra nibh cras pulvinar. In ornare quam viverra orci sagittis eu volutpat odio. Quam lacus suspendisse faucibus interdum. Dignissim enim sit amet venenatis. A condimentum vitae sapien pellentesque habitant morbi.")),
          const SizedBox(
            height: 8,
          ),
          Project(
            tags: [
              Tag(
                  name: "Spring",
                  color: Colors.green,
                  child: buildTagRemoveButton(context)),
              Tag(
                name: "Java",
                color: Colors.red,
                child: buildTagRemoveButton(context),
              ),
            ],
            data: ProjectData("name",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
          ),*/
        ],
      ),
    );
  }
}
