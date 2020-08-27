import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../view/detail_view.dart';
import '../shared/constants.dart';

class HomeViewModel {
  final Stream<QuerySnapshot> _fireStore = Firestore.instance.collection(ProductStrings.kCollection).snapshots();
  final SliverGridDelegateWithFixedCrossAxisCount _gird = SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);

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
                return FlatButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailView(data),
                      ),
                    );
                  },
                  child: Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: _size.height * .15,
                          child: Image.asset(
                            'assets/${data[ProductStrings.kimage]}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '${data[ProductStrings.kName]}',
                            style: kPriceStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: _size.width * .055,
                            ),
                          ),
                          trailing: Text(
                            '${data[ProductStrings.kPrice]} \$',
                            style: kPriceStyle.copyWith(
                              fontSize: _size.width * .05,
                            ),
                          ),
                        ),
                      ],
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
