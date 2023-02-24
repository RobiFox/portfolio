import 'package:flutter/material.dart';
import 'package:robi_portfolio/string_apis.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double _radius = 64;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return SizedBox(
      width: width,
      height: height + _radius,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(_radius), bottomLeft: Radius.circular(_radius)),
                image: DecorationImage(
                  image: AssetImage("images/background.png".asAsset()),
                  fit: BoxFit.cover,
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Robi",
                      style: GoogleFonts.roboto(
                          textStyle:
                          TextStyle(color: Colors.white, fontSize: 92)),
                    ),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          launchUrl(Uri.parse("https://github.com/RobiFox"));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(64)),
                            backgroundColor: Colors.white),
                        child: Transform.scale(
                          scale: 2.5,
                          child: Image.asset(
                              "icons/github-mark.png".asAsset(),
                              fit: BoxFit.contain),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
