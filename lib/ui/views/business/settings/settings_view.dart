import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_text_style.dart';
import 'package:mycustomers/ui/views/business/settings/settings_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/size_extension.dart';



class SettingsHomePageView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440, width: 720, allowFontScaling: true);

    return ViewModelBuilder<SettingsHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title:Text(model.pageTitle,
          style: kheadingText
          ),
          elevation:1.0,
          centerTitle: true,
          backgroundColor: ThemeColors.background,
          iconTheme: IconThemeData(
            color: BrandColors.primary
          ),
        ),
        body: SafeArea(
            child:Container(

              padding: EdgeInsets.symmetric(horizontal:24.w),
              margin: EdgeInsets.only(top:8.h),
              child: Column(
                children : <Widget>[
                  Container(
                    height: 80.h,
                    margin: EdgeInsets.only(top:6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.sp),
                      color:Color.fromRGBO(196, 196, 196, 0.05),
                      border:Border.all(
                          color: Color.fromRGBO(196, 196, 196, 0.05),
                          width: 0.5
                    ),
                      
                    ),
                    child:Row(
                      children:<Widget>[
                        Text(model.languageTitle, style:model.mainTextStyle),
                        Spacer(),
                        Text(model.userLanguage, style: model.prefTextStyle),
                        IconButton(
                          onPressed: (){
                            //TODO Implement function to navigate to Language screen
                          },
                          icon: Icon(Icons.arrow_forward_ios,
                          color: Color(0xff4f4f4f),
                          ),
                        )
                      ]
                    )
                  ),
                  Divider(),

                  Container(
                    height:80.h,
                    margin: EdgeInsets.only(top:6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.sp),
                      color:Color.fromRGBO(196, 196, 196, 0.05),
                      border:Border.all(
                          color: Color.fromRGBO(196, 196, 196, 0.05),
                          width: 0.5
                    ),),

                    child: Row(
                      children:<Widget>[
                        Text(model.currencyHeading,
                        style: model.mainTextStyle,
                        ),
                        Spacer(),
                        Text(model.currencyType,
                        style:model.prefTextStyle),
                        IconButton(
                          onPressed: (){
                             //TODO Implement function to navigate to Language screen
                          },
                          icon: Icon(Icons.arrow_forward_ios),
                          color: Color(0xff4f4f4f),
                          )

                      ]
                    ),
                  ),
                  Divider(),

                  Container(
                    height: 75.h,
                    margin: EdgeInsets.only(top:6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.sp),
                      color:Color.fromRGBO(196, 196, 196, 0.05),
                      border:Border.all(
                          color: Color.fromRGBO(196, 196, 196, 0.05),
                          width: 0.5
                    ),),
                    child: Row(
                      children:<Widget>[
                        Text(model.appLockHeading, style:model.mainTextStyle),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios,
                          color: Color(0xff4f4f4f),
                          ), 
                          onPressed: null)

                      ]
                    ),
                  ),
                  Divider(),
                  togglePrefSection(model, context),
                  Spacer(),

                  Container(
                    height: 105.h,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom:18.h),
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(8.sp),
                      color: BrandColors.primary
                      
                    ),
                    child:FlatButton(
                      onPressed:(){
                        //TODO Implement the action to be completed once the user clicks the save button
                      } ,
                      child: Text(
                        model.btnText,
                        textAlign: TextAlign.center,
                        style:TextStyle(
                          color:ThemeColors.background,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 32.sp,
                        )
                      )) ,),
                ]
              ),
            ),
      ),
      ),
      viewModelBuilder: () => SettingsHomePageViewModel(),
    );
  }
}


Expanded buildListTileSwitch(String heading, Function onChanged,bool value){
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical:6.h),
      child: SwitchListTile(
        title:Text(heading),
        value: value, 
        onChanged:onChanged,
        activeColor:ThemeColors.background ,
        activeTrackColor:BrandColors.primary ,
        
        ),
    ));
}



Widget togglePrefSection(SettingsHomePageViewModel model, BuildContext context) => Expanded(
  child: Container(
    margin: EdgeInsets.only(top: 12.h),
    padding: EdgeInsets.symmetric(horizontal:14.w),
    height: 400.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.sp),
      color: Color.fromRGBO(196, 196, 196, 0.05),
      border:Border.all(
          color: Color.fromRGBO(196, 196, 196, 0.05),
          width: 0.5
    ),

  ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildListTileSwitch(model.notification, model.onChanged, model.switchValue),
        Divider(
          color: Color.fromRGBO(151, 151, 151, 0.1),
          height: 0.5.h,
        ),
        buildListTileSwitch(model.newsletter, model.onChanged, model.switchValue),
        Divider(
          color: Color.fromRGBO(151, 151, 151, 0.1),
          height: 0.5.h,
        ),
        buildListTileSwitch(model.specialOffers, model.onChanged, model.switchValue),
        Divider(
          color: Color.fromRGBO(151, 151, 151, 0.1),
          height: 0.5.h,
        ),
        buildListTileSwitch(model.updates, model.onChanged, model.switchValue),
        Divider(
          color: Color.fromRGBO(151, 151, 151, 0.1),
          height: 0.5.h,
        ),

      ],),
  ),
);