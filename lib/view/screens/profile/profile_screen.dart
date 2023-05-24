import 'package:the_best_food/controller/auth_controller.dart';
import 'package:the_best_food/controller/splash_controller.dart';
import 'package:the_best_food/controller/theme_controller.dart';
import 'package:the_best_food/helper/route_helper.dart';
import 'package:the_best_food/util/app_constants.dart';
import 'package:the_best_food/util/dimensions.dart';
import 'package:the_best_food/util/images.dart';
import 'package:the_best_food/util/styles.dart';
import 'package:the_best_food/view/base/confirmation_dialog.dart';
import 'package:the_best_food/view/screens/profile/widget/profile_bg_widget.dart';
import 'package:the_best_food/view/screens/profile/widget/profile_button.dart';
import 'package:the_best_food/view/screens/profile/widget/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<AuthController>(builder: (authController) {
        return authController.profileModel == null ? Center(child: CircularProgressIndicator()) : ProfileBgWidget(
          backButton: false,
          circularImage: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Theme.of(context).cardColor),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: ClipOval(child: FadeInImage.assetNetwork(
              placeholder: Images.placeholder,
              image: '${Get.find<SplashController>().configModel.baseUrls.deliveryManImageUrl}'
                  '/${authController.profileModel != null ? authController.profileModel.image : ''}',
              height: 100, width: 100, fit: BoxFit.cover,
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 100, width: 100, fit: BoxFit.cover),
            )),
          ),
          mainWidget: SingleChildScrollView(physics: BouncingScrollPhysics(), child: Center(child: Container(
            width: 1170, color: Theme.of(context).cardColor,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Column(children: [

              Text(
                '${authController.profileModel.name}',
                style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
              ),
              SizedBox(height: 30),

              Row(children: [

                ProfileCard(title: 'since_joining'.tr, data: '${authController.profileModel.memberSinceDays} ${'days'.tr}'),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                ProfileCard(title: 'total_order'.tr, data: authController.profileModel.orderCount.toString()),
              ]),
              SizedBox(height: 30),

              ProfileButton(
                icon: Icons.notifications, title: 'notification'.tr,
                isButtonActive: authController.notification, onTap: () {
                  authController.setNotificationActive(!authController.notification);
                },
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                  ProfileButton(icon: Icons.language, title: 'Language'.tr, onTap: () {
                    Get.toNamed(RouteHelper.getLanguageRoute());
                  }),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  ProfileButton(icon: Icons.edit, title: 'edit_profile'.tr, onTap: () {
                    Get.toNamed(RouteHelper.getUpdateProfileRoute());}),

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              ProfileButton(icon: Icons.lock, title: 'change_password'.tr, onTap: () {
                Get.toNamed(RouteHelper.getResetPasswordRoute('', '', 'password-change'));
              }),

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              /*ProfileButton(icon: Icons.list, title: 'terms_condition'.tr, onTap: () {
                Get.toNamed(RouteHelper.getTermsRoute());
              }),*/
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              ProfileButton(icon: Icons.privacy_tip, title: 'privacy_policy'.tr, onTap: () {
                Get.toNamed(RouteHelper.getPrivacyRoute());
              }),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              ProfileButton(icon: Icons.logout, title: 'logout'.tr, onTap: () {
                Get.back();
                Get.dialog(ConfirmationDialog(icon: Images.support, description: 'are_you_sure_to_logout'.tr, isLogOut: true, onYesPressed: () {
                  Get.find<AuthController>().clearSharedData();
                  Get.find<AuthController>().stopLocationRecord();
                  Get.offAllNamed(RouteHelper.getSignInRoute());
                }));
              }),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('${'version'.tr}:', style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(AppConstants.APP_VERSION.toString(), style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
              ]),

            ]),
          ))),
        );
      }),
    );
  }
}
