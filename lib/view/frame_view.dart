import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/isLoding_model.dart';
import 'package:provider/provider.dart';
import '../controller/change_seen_controller.dart';
import 'sigin_view.dart';
import 'package:toast/toast.dart';
import '../shared/constants.dart';
import 'cart_view.dart';
import 'home_view.dart';
import '../shared/app_theme.dart';

class FrameView extends StatefulWidget {
  static const String route = '/Frame';
  @override
  _FrameViewState createState() => _FrameViewState();
}

class _FrameViewState extends State<FrameView> {
  SigOut _out = SigOut();
  int _currentIndex = 0;
  final List<Widget> _views = [
    HomeVeiw(),
    CartVeiw(),
  ];

  _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  String _appBarDeterminer() {
    if (_currentIndex == 0) {
      return 'Home';
    } else if (_currentIndex == 1) {
      return 'Cart';
    } else {
      return 'Shop';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLodingModel = Provider.of<IsLodingModel>(context);
    return isLodingModel.isLoding == false
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                _appBarDeterminer().toString(),
                style: kAppBarStyle,
              ),
              backgroundColor: Theme.of(context).accentColor,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _out.sigOut(context, isLodingModel);
                  },
                ),
              ],
              
            ),
            body: _views.elementAt(_currentIndex),
            bottomNavigationBar: BottomNavigationBar(
              onTap: _onTap,
              currentIndex: _currentIndex,
              selectedItemColor: Theme.of(context).accentColor,
              unselectedItemColor: AppTheme.unSelected,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 16,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text("Cart"),
                ),
              ],
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          );
  }
}

class SigOut {
  ChangeSeenController _seen = ChangeSeenController();

  void sigOut(BuildContext context, IsLodingModel isLodingModel) async {
    try {
      isLodingModel.changeLoding(true);
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil(
        SiginView.route,
        (route) => false,
      );
      _seen.makeSeenFalse();
      isLodingModel.changeLoding(false);
    } on PlatformException catch (e) {
      isLodingModel.changeLoding(false);
      Toast.show(
        '${e.message}',
        context,
        gravity: Toast.BOTTOM,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Theme.of(context).accentColor,
      );
    }
  }
}
