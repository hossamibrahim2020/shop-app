import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';
import 'detail_view.dart';

class HomeVeiw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firestorData(context),
    );
  }

  final Stream<QuerySnapshot> _fireStore =
      Firestore.instance.collection(ProductStrings.kCollection).snapshots();
  final SliverGridDelegateWithFixedCrossAxisCount _gird =
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);

  StreamBuilder<QuerySnapshot> firestorData(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: _fireStore,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString().toLowerCase(),
              style: kerrorStyle,
            ),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return indicator(context);
            break;
          default:
            return GridView.builder(
              gridDelegate: _gird,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot data = snapshot.data.documents[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailView(data),
                        ),
                      );
                    },
                    child: GridTile(
                      child: Container(
                        height: _size.height * .15,
                        child: Image.asset(
                          'assets/${data[ProductStrings.kimage]}',
                        ),
                      ),
                      footer: Container(
                        color: Colors.white70,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${data[ProductStrings.kName]}',
                                style: kPriceStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: _size.width * .055,
                                ),
                              ),
                              Text(
                                '${data[ProductStrings.kPrice]} \$',
                                style: kPriceStyle.copyWith(
                                  fontSize: _size.width * .05,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }

  Center indicator(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
