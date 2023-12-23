import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart.dart';
import 'detail.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late CollectionReference sparepartCollection;
  String searchQuery = '';
  @override
  void initState() {
    super.initState();
    sparepartCollection = FirebaseFirestore.instance.collection('sparepart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade50, Colors.blue.shade50])),
          constraints: BoxConstraints(
              maxHeight: double.infinity,
              minHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width),
          child: Column(
            children: [
              CupertinoSearchTextField(
                backgroundColor: Colors.white,
                itemColor: Colors.blue.shade500,
                borderRadius: BorderRadius.circular(20),
                onSubmitted: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<QuerySnapshot>(
                future: sparepartCollection.get(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("error : ${snapshot.error}");
                  } else {
                    var sparepartDocs = snapshot.data!.docs;

                    // Filter sparepartDocs based on the search query
                    var filteredSparepartDocs = sparepartDocs
                        .where((doc) => doc['name']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()))
                        .toList();

                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 220),
                        itemCount: filteredSparepartDocs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext ctx, index) {
                          var data = sparepartDocs[index].data()
                              as Map<String, dynamic>;
                          var documentId = sparepartDocs[index].id;
                          return InkWell(
                            onTap: () {
                              List<dynamic> assets = sparepartDocs[index]
                                  ['assets'] as List<dynamic>;
                              List<String> images = assets
                                  .map((asset) => asset.toString())
                                  .toList();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                            sparepartId: documentId,
                                            name: sparepartDocs[index]['name'],
                                            category: sparepartDocs[index]
                                                ['category'],
                                            desc: sparepartDocs[index]
                                                ['description'],
                                            price: sparepartDocs[index]['price']
                                                .toString(),
                                            images: images,
                                            // ^ Assuming 'assets' is the field with an array of image URLs
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 160,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              data['assets'][1].toString() ??
                                                  '')),
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 4),
                                    child: Text(
                                      data['name'] ?? '',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        overflow: TextOverflow.fade,
                                      )),
                                      maxLines: 1,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "RP. ${data['price'] ?? ''}",
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 13)),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    blurRadius: 5,
                                                    spreadRadius: 0.5)
                                              ]),
                                          padding: EdgeInsets.all(2),
                                          child: Icon(Icons.add,
                                              color: Colors.grey.shade600,
                                              size: 20),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
