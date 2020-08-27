import 'package:flutter/material.dart';
import 'controller/cart_provider.dart';
import 'admin/add_product.dart';
import 'admin/view_order.dart';
import 'admin/admin_pannel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/isLoding_model.dart';
import 'model/is_visiable_model.dart';
import 'package:provider/provider.dart';
import 'view/sigin_view.dart';
import 'view/regester_view.dart';
import 'shared/app_theme.dart';
import 'view/frame_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = FrameView.route;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.get('seen');
  if (seen == true) {
    initialRoute = FrameView.route;
  } else if (seen == false || seen == null) {
    initialRoute = SiginView.route;
  }
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<IsVisiabelModel>(
          create: (BuildContext context) => IsVisiabelModel(),
        ),
        ChangeNotifierProvider<IsLodingModel>(
          create: (BuildContext context) => IsLodingModel(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (BuildContext context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          AdminPannel.route: (context) => AdminPannel(),
          AddProduct.route: (context) => AddProduct(),
          ViewOrders.route: (context) => ViewOrders(),
          SiginView.route: (context) => SiginView(),
          RegesterView.route: (context) => RegesterView(),
          FrameView.route: (context) => FrameView(),
        },
      ),
    );
  }
}
