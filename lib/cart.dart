import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                width: 220,
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                          blurStyle: BlurStyle.normal)
                    ],
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.horizontal(left: Radius.circular(5)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/landing.png"))),
                    ),
                    Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Brembo RCS Corsa Corta",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 14)),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rp.12.000.000",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.blue.shade500,
                                            fontSize: 14)),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add_circle_outline,
                                size: 20,
                              )),
                          Text(
                            "0",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 14)),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.remove_circle_outline,
                                size: 20,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }
}
