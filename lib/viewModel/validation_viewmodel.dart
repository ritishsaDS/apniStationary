import 'package:get/get.dart';

class ValidationViewModel extends GetxController {
  RxBool forgotPasswordFlag = false.obs;
  RxInt forgotPasswordPageIndex = 0.obs;
  RxBool progressVisible = false.obs;
  RxBool termCondition = false.obs;
  RxBool rememberLogin = false.obs;
  RxBool isLoading = false.obs;
  RxBool loginPasswordObscure = true.obs;
  RxBool passwordObscure = true.obs;
  RxBool confirmPasswordObscure = true.obs;
  RxString selectRole = ''.obs;

  void updateIsLoading(bool status) {
    isLoading = status.obs;
    update();
  }

  void updateRole(String role) {
    selectRole = role.obs;
    update();
  }

  void updateWidget() {
    update();
  }

  void chnageTC() {
    print("Controllar call");
    termCondition = termCondition.toggle();
    update();
  }

  void loginPasswordToggle() {
    loginPasswordObscure = loginPasswordObscure.toggle();
    update();
  }

  void passwordToggle() {
    passwordObscure = passwordObscure.toggle();
    update();
  }

  void confirmPasswordToggle() {
    confirmPasswordObscure = confirmPasswordObscure.toggle();
    update();
  }
}
