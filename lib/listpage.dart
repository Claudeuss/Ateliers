import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart.dart';
import 'detail.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage()));
                      },
                      child: Container(
                        height: 300,
                        width: 160,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                  offset: Offset(0, 3),
                                  blurStyle: BlurStyle.normal)
                            ]),
                        child: Column(
                          children: [
                            Container(
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/landing.png"),
                                      fit: BoxFit.fill)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: Text(
                                              "brembo rc hansfb abfms",
                                              style: GoogleFonts.poppins(
                                                  textStyle:
                                                      TextStyle(fontSize: 13)),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          Container(
                                            height: 25,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            child: Text(
                                              "Rp.20.000.000",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.blue[600])),
                                            ),
                                          )
                                        ],
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.grey[600],
                                            )),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
