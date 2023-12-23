import 'package:apps_ateliers/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CollectionReference sparepartCollection;
  late CollectionReference cartCollection;
  int number = 0;
  @override
  void initState() {
    super.initState();
    sparepartCollection = FirebaseFirestore.instance.collection('sparepart');
    cartCollection = FirebaseFirestore.instance.collection('cart');
  }

  Future<void> _deleteCartItem(String documentId) async {
    bool confirmDelete = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content:
              Text('Are you sure you want to delete this item from the cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                confirmDelete = true;
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete) {
      try {
        await cartCollection.doc(documentId).delete();

        // Rebuild the widget's state after deletion
        setState(() {});

        // Show a notification to confirm deletion
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Item Deleted'),
          ),
        );
      } catch (error) {
        print("Error deleting item from cart: $error");
        // Handle error accordingly
      }
    }
  }

  double calculateTotalPrice(List<QueryDocumentSnapshot> documents) {
    double totalPrice = 0.0;
    for (var document in documents) {
      // Assuming 'price' is the field in your document that represents the price
      totalPrice += double.parse(document['price'].toString());
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.blue[500], fontSize: 20)),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 0,
        leadingWidth: 25,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
        ),
        constraints: BoxConstraints(
            maxHeight: double.infinity,
            maxWidth: MediaQuery.of(context).size.width),
        child: FutureBuilder(
          future: cartCollection.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("error : ${snapshot.error}");
            } else {
              var cartItemDocs =
                  snapshot.data!.docs; // Obtain the documents from the snapshot
              return ListView.builder(
                  itemCount: cartItemDocs.length,
                  itemBuilder: ((context, index) {
                    var data =
                        cartItemDocs[index].data() as Map<String, dynamic>;
                    var documentId = cartItemDocs[index].id;
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        padding: EdgeInsets.all(5),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.grey.shade300,
                            //       blurRadius: 4,
                            //       spreadRadius: 2,
                            //       offset: Offset(0, 3),
                            //       blurStyle: BlurStyle.normal)
                            // ],
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 90,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: data['assets'] is List
                                          ? NetworkImage(data['assets'][0])
                                          : NetworkImage(
                                              data['assets'] ?? ''))),
                            ),
                            Container(
                              width: 145,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      data['name'] ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            data['price'].toString(),
                                            textAlign: TextAlign.start,
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    child: Container(
                                      child: InkWell(
                                        onTap: () {
                                          _deleteCartItem(documentId);
                                        },
                                        child: Icon(
                                          Icons.delete_outline,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            number--;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(width: 1)),
                                          child: Icon(
                                            CupertinoIcons.minus,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          number.toString(),
                                          style: GoogleFonts.poppins(
                                              textStyle:
                                                  TextStyle(fontSize: 14)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            number++;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(width: 1)),
                                          child: Icon(
                                            CupertinoIcons.plus,
                                            size: 14,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }));
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3,
                spreadRadius: 3,
                offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Rp 500000",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(),
                  child: Center(
                    child: Text(
                      "Confirm",
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
