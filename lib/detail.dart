import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
int _current = 0;
final CarouselController _controller = CarouselController();

class DetailPage extends StatefulWidget {
  final List<String> images;
  const DetailPage(
      {Key? key,
      required this.sparepartId,
      required this.name,
      required this.category,
      required this.desc,
      required this.price,
      required this.images})
      : super(key: key);

  final String name, category, desc, price, sparepartId;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // Inside the _DetailPageState class

  Future<void> _showAddToCartDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Added to Cart'),
          content: Text('The item has been added to your cart.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showItemAlreadyInCartDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Item Already in Cart'),
          content: Text('This item is already in your cart.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addToCart() async {
    // Check if the item with the same sparepart-id already exists in the cart
    var existingItem = await FirebaseFirestore.instance
        .collection('cart')
        .where('sparepart-id', isEqualTo: widget.sparepartId)
        .get();

    if (existingItem.docs.isEmpty) {
      // If the item doesn't exist, add it to the cart
      FirebaseFirestore.instance.collection('cart').doc().set({
        'sparepart-id': widget.sparepartId,
        'name': widget.name,
        'desc': widget.desc,
        'category': widget.category,
        'price': widget.price,
        'assets': widget.images,
      });

      // Show the add to cart dialog
      _showAddToCartDialog();
    } else {
      // If the item already exists, show a dialog indicating that it's already in the cart
      _showItemAlreadyInCartDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.blue,
        scrolledUnderElevation: 5,
        leadingWidth: 25,
        title: Text(
          "Detail",
          style: GoogleFonts.poppins(
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
        ),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.category,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ),
                Text(
                  widget.name,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 250,
                    viewportFraction: 1,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: widget.images
                      .map((imageUrl) => Container(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        width: 350,
                                        height: 250,
                                      ),
                                      // Positioned(
                                      //   bottom: 0.0,
                                      //   left: 0.0,
                                      //   right: 0.0,
                                      //   child: Container(
                                      //     decoration: BoxDecoration(
                                      //       gradient: LinearGradient(
                                      //         colors: [
                                      //           Color.fromARGB(200, 0, 0, 0),
                                      //           Color.fromARGB(0, 0, 0, 0)
                                      //         ],
                                      //         begin: Alignment.bottomCenter,
                                      //         end: Alignment.topCenter,
                                      //       ),
                                      //     ),
                                      //     padding: EdgeInsets.symmetric(
                                      //         vertical: 10.0, horizontal: 20.0),
                                      //   ),
                                      // ),
                                    ],
                                  )),
                            ),
                          ))
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.blue)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Description Product',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.desc ?? '',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontSize: 15,
                  )),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3,
              spreadRadius: 3,
              offset: Offset(0, 3))
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Rp${widget.price.toString()}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 18, color: Colors.black)),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Call the _addToCart method instead of directly adding to the cart
                    _addToCart();
                  });
                },
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(),
                  child: Center(
                    child: Text(
                      "+Add to Cart",
                      style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 13)),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
