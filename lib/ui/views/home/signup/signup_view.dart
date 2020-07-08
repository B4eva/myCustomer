
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/social_icon.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'signup_viewmodel.dart';

class SignUpView extends StatelessWidget {
  final _signupPageKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        key: _signupPageKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: BrandColors.primary,
        body: CustomBackground(child: _PartialBuildForm()),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}

class _PartialBuildForm extends HookViewModelWidget<SignUpViewModel> {
  static final _signupFormPageKey = GlobalKey<FormState>();
  final bool busy;

  _PartialBuildForm({Key key, this.busy}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, SignUpViewModel viewModel) {
    var _inputSignupNumberController = useTextEditingController();
    var _userPassword = useTextEditingController();

    return Form(
      key: _signupFormPageKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.yMargin(context, 3)),
          Text(
            'SIGN UP',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: SizeConfig.textSize(context, 6),
            ),
          ),
          // SizedBox(height: SizeConfig.xMargin(context, 2)),
          // Text(
          //   'Please Enter your Phone number',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: SizeConfig.yMargin(context, 2),
          //   ),
          // ),
          SizedBox(height: SizeConfig.yMargin(context, 1.3)),
          Container(
            height: SizeConfig.yMargin(context, 14),
            width: SizeConfig.xMargin(context, 90),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                viewModel.number = number;
                // print('Phone changed');
              },
              // onInputValidated: (bool value) {
              //   viewModel.phoneValid = value;
              //   viewModel.activeBtn();
              //   print('Value is: $value');
              // },
              ignoreBlank: false,
              // autoValidate: true,
              // countries: ['NG', 'GH', 'BJ' 'TG', 'CI'],
              errorMessage: 'Invalid Phone Number',
              selectorType: PhoneInputSelectorType.DIALOG,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: viewModel.number,
              textFieldController: _inputSignupNumberController,
              // inputBorder: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
            child: TextFormField(
              key: Key("userpassword"),
              controller: _userPassword,
              obscureText: viewModel.obscureText,
              // viewModel.obscureText,
              validator: (_) => viewModel.validatePassword(_userPassword.text),
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: SizeConfig.yMargin(context, 2),
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
              // autovalidate: true,
              // onChanged: (_) {
              //   viewModel.validatePassword(_userPassword.text);
              //   viewModel.activeBtn();
              // },
              decoration: InputDecoration(
                // suffixIcon: _CustomPartialBuildWidget<SignUpViewModel>(
                //   builder: (BuildContext context, SignUpViewModel viewModel) =>
                //       IconButton(
                //     icon: Icon(
                //       // Based on obscureText state choose the icon
                //       viewModel.obscureText
                //           ? Icons.visibility
                //           : Icons.visibility_off,
                //       color: Theme.of(context).primaryColorDark,
                //     ),
                //     onPressed: () {
                //       // Update the state i.e. toogle the state of obscureText variable
                //       viewModel.togglePassword();
                //     },
                //   ),
                // ),
                labelText: "Password",
                // border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.yMargin(context, 3)),
          AuthButton(
            btnColor: BrandColors.primary,
            txtColor: ThemeColors.background,
            btnText: 'Next',
            onPressed: () async {
              // viewModel.signUpTest();
              if (!_signupFormPageKey.currentState.validate()) return;

              //Dismiss keyboard during async call
              FocusScope.of(context).requestFocus(FocusNode());

              //Call Function to Signup
              viewModel.signUp(
                '0' +
                    int.parse(_inputSignupNumberController.text
                        .splitMapJoin(' ', onMatch: (_) => '')).toString(),
                _userPassword.text.trim(),
              );
            },
            child: Icon(
              Icons.arrow_forward,
              color: ThemeColors.background,
              size: SizeConfig.yMargin(context, 2.5),
            ),
          ),

          SizedBox(height: SizeConfig.yMargin(context, 5)),
//          Text(
//            'or Continue with your social accounts',
//            textAlign: TextAlign.center,
//            style: TextStyle(
//              color: Color(0xFF02034A),
//              fontSize: 16.sp,
//            ),
//          ),
//          SizedBox(height: SizeConfig.yMargin(context, 1)),
//
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              SocialIconButton(
//                onTap: () {},
//                socialIconUrl: 'assets/icons/google_icon.png',
//              ),
//              SocialIconButton(
//                onTap: () {},
//                socialIconUrl: 'assets/icons/facebook_icon.png',
//              ),
//              SocialIconButton(
//                onTap: () {},
//                socialIconUrl: 'assets/icons/apple_icon.png',
//              ),
//            ],
//          ),
          // Spacer(),
          // SizedBox(height: SizeConfig.yMargin(context, 6)),
          AuthButton(
            btnColor: ThemeColors.unselect,
            txtColor: BrandColors.primary,
            btnText: 'Already a Member? Sign In',
            child: Container(),
            onPressed: () async {
              // dismiss keyboard during async call
              FocusScope.of(context).requestFocus(FocusNode());

              // Route Screen to Login
              viewModel.navigateToLogin();
            },
          ),

          SizedBox(height: SizeConfig.yMargin(context, 9)),
          Container(
              width: SizeConfig.xMargin(context, 60),
              child: CustomizeProgressIndicator(1, 4)),
          Expanded(child: SizedBox(height: SizeConfig.yMargin(context, 6))),
        ],
      ),
    );
  }
}
