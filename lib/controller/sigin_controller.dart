import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../view/regester_view.dart';
import 'package:toast/toast.dart';
import '../model/isLoding_model.dart';
import '../view/frame_view.dart';
import 'change_seen_controller.dart';

class SiginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChangeSeenController _seen = ChangeSeenController();

  isVisiableRun(final _isVisiableController) {
    _isVisiableController.isVisiable == false
        ? _isVisiableController.changeVisiable(true)
        : _isVisiableController.changeVisiable(false);
  }

  void transationToSigin(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RegesterView.route,
      (route) => false,
    );
  }

  void regesterButton(
    BuildContext context,
    GlobalKey<FormState> _key,
    TextEditingController email,
    TextEditingController password,
    IsLodingModel _isloding,
  ) async {
    if (_key.currentState.validate()) {
      try {
        _isloding.changeLoding(true);
        await _auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        _seen.makeSeenTrue();
        Navigator.of(context).pushNamedAndRemoveUntil(
          FrameView.route,
          (route) => false,
        );
        _isloding.changeLoding(false);
      } on PlatformException catch (e) {
        _isloding.changeLoding(false);
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
}
