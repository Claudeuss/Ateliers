import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceForm extends StatefulWidget {
  const ServiceForm({super.key});

  @override
  State<ServiceForm> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 30),
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade500],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight)),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          )),
                      Container(
                        height: 180,
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/vectorart-upload.svg',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Form Service",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 15)),
                            decoration: InputDecoration(
                                hintText: 'Your Name',
                                hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(fontSize: 15)),
                                icon: Icon(
                                  CupertinoIcons.person_crop_circle,
                                  size: 40,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 15)),
                            decoration: InputDecoration(
                                hintText: 'Motorcycle',
                                hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(fontSize: 15)),
                                icon: Icon(
                                  Icons.motorcycle_outlined,
                                  size: 40,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 15)),
                            decoration: InputDecoration(
                                hintText: 'Address',
                                hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(fontSize: 15)),
                                icon: Icon(
                                  Icons.location_pin,
                                  size: 40,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: 300,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade500,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {},
                              child: Text(
                                'Confirm',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
