import 'package:flutter/material.dart';
import 'package:livingtechassignment/screens/auth/repository/auth_repository.dart';
import 'package:livingtechassignment/screens/auth/view/login_screen.dart';
import 'package:livingtechassignment/screens/dashboard/view/dashboard.dart';
import 'package:livingtechassignment/utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();

  TextEditingController regPassController = TextEditingController();
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regUserNameController = TextEditingController();

  bool _isObsure = true;
  bool get isObscure => _isObsure;

  set isObscure(bool value) {
    _isObsure = value;
    notifyListeners();
  }

  bool _isObsureReg = true;
  bool get isObscureReg => _isObsureReg;

  set isObscureReg(bool value) {
    _isObsureReg = value;
    notifyListeners();
  }

  bool _isLoadingReg = false;
  bool get isLoadingReg => _isLoadingReg;

  set isLoadingReg(bool value) {
    _isLoadingReg = value;
    notifyListeners();
  }

  bool _isLoadingLogin = false;
  bool get isLoadingLogin => _isLoadingLogin;

  set isLoadingLogin(bool value) {
    _isLoadingLogin = value;
    notifyListeners();
  }

  Future login({
    required BuildContext context,
  }) async {
    isLoadingLogin = true;
    final apiResponse = await AuthRepository.instance.login(
      email: loginEmailController.text,
      password: loginPassController.text,
    );
    apiResponse.fold(
      (l) {
        Utils.showSnackBar(l.error ?? 'Something went wrong');
      },
      (r) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
        loginEmailController.clear();
        loginPassController.clear();
      },
    );
    isLoadingLogin = false;
  }

  Future register({
    required BuildContext context,
  }) async {
    isLoadingReg = true;
    final apiResponse = await AuthRepository.instance.register(
      name: regUserNameController.text,
      email: regEmailController.text,
      password: regPassController.text,
    );
    apiResponse.fold(
      (l) {
        Utils.showSnackBar(l.error ?? 'Something went wrong');
      },
      (r) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
        regEmailController.clear();
        regPassController.clear();
        regUserNameController.clear();
      },
    );
    isLoadingReg = false;
  }
}
