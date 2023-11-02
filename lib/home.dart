import 'package:apps_ateliers/category.dart';
import 'package:apps_ateliers/serviceform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/landing.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Color.fromRGBO(0, 6, 137, 70), BlendMode.darken))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/4 1.png"),
                width: 180,
                height: 180,
              ),
              Text("ATELIERS.GO",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: Colors.white, fontSize: 20))),
              SizedBox(
                height: 50,
              ),
              Text(
                "Welcome to Ateliers",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "aliquet sagittis id consectetur purus ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt vitae semper quis lectus nulla",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.white, fontSize: 12)),
              ),
              SizedBox(
                height: 80,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage()));
                  },
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Text(
                        "Catalog",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ServiceForm()));
                  },
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Text(
                        "Service",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
