import 'package:apps_ateliers/listpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Categories",
          style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 18)),
        ),
        // title: Text("Category"),
        titleTextStyle: GoogleFonts.poppins(
            textStyle: TextStyle(color: Colors.white, fontSize: 17)),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        padding: EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue.shade900,
          Colors.blue.shade700,
          Colors.blue.shade500
        ], begin: Alignment.topLeft)),
        child: Column(
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            // Center(
            //   child: Text(
            //     "Categories",
            //     style: GoogleFonts.poppins(
            //         textStyle: TextStyle(
            //             // color: Colors.blue[500],
            //             color: Colors.black,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w500)),
            //   ),
            // ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListPage()));
                  },
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            width: 140,
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Text(
                          "Wheels & Tires",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          width: 140,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Text(
                        "Engine Parts",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          width: 140,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Text(
                        "Accesories",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 4,
                            blurStyle: BlurStyle.normal,
                            offset: Offset(0, 2))
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          width: 140,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Center(
                        child: Text(
                          " Maintenance",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
