import '../model/isLoding_model.dart';
import '../model/is_visiable_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../controller/regester_controller.dart';
import '../shared/widgets/custom_curve_shap.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../shared/widgets/custom_text_form_field.dart';
import '../shared/widgets/custom_circle_button.dart';

class RegesterView extends StatefulWidget {
  static const String route = '/regester';
  @override
  _RegesterViewState createState() => _RegesterViewState();
}

class _RegesterViewState extends State<RegesterView> {
  final String regester = 'Regester';
  final RegesterController _regesterController = RegesterController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    this._name.dispose();
    this._email.dispose();
    this._password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isVisiableModel = Provider.of<IsVisiabelModel>(context);
    final _isLodingModel = Provider.of<IsLodingModel>(context);
    return _isLodingModel.isLoding == true
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(regester, style: kauthStyle),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomCurveShap(),
                    CustomTextFormField(
                      label: 'Name',
                      icon: Icons.person,
                      textInputType: TextInputType.emailAddress,
                      obscure: false,
                      validat: (String value) {
                        return value.length < 4 ? 'enter valid name' : null;
                      },
                      controller: _name,
                    ),
                    CustomTextFormField(
                      label: 'Email',
                      icon: Icons.email,
                      textInputType: TextInputType.emailAddress,
                      obscure: false,
                      validat: (String value) {
                        return value.length < 6 ? 'enter valid email' : null;
                      },
                      controller: _email,
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      icon: Icons.lock,
                      textInputType: TextInputType.number,
                      validat: (String value) {
                        return value.length < 6 ? 'enter valid password' : null;
                      },
                      controller: _password,
                      obscure: _isVisiableModel.isVisiable,
                      visiableIcon: FlatButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          _regesterController.isVisiableRun(_isVisiableModel);
                        },
                        child: FaIcon(
                          _isVisiableModel.isVisiable == false
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                        ),
                      ),
                    ),
                    CustomCircleButton(
                      label: regester,
                      color: Theme.of(context).accentColor,
                      onpress: () {
                        _regesterController.regesterButton(
                          context,
                          _key,
                          _email,
                          _password,
                          _isLodingModel,
                        );
                      },
                      horizontal: 16,
                      vertical: 20,
                    ),
                    FlatButton(
                      onPressed: () {
                        _regesterController.transationToSigin(context);
                      },
                      child: Text('have an account? Sigin'),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
