import 'package:get/get.dart';
import 'package:pink_acg/app/middlewares/auth_middleware.dart';
import 'package:pink_acg/app/modules/aboutApp/bindings/about_app_binding.dart';
import 'package:pink_acg/app/modules/aboutApp/views/about_app_view.dart';
import 'package:pink_acg/app/modules/aboutUs/bindings/about_us_binding.dart';
import 'package:pink_acg/app/modules/aboutUs/views/about_us_view.dart';
import 'package:pink_acg/app/modules/chat/bindings/chat_binding.dart';
import 'package:pink_acg/app/modules/chat/views/chat_view.dart';
import 'package:pink_acg/app/modules/contact/bindings/contact_binding.dart';
import 'package:pink_acg/app/modules/contact/views/contact_view.dart';
import 'package:pink_acg/app/modules/darkMode/bindings/dark_mode_binding.dart';
import 'package:pink_acg/app/modules/darkMode/views/dark_mode_view.dart';
import 'package:pink_acg/app/modules/dynamic/bindings/dynamic_binding.dart';
import 'package:pink_acg/app/modules/dynamic/views/dynamic_view.dart';
import 'package:pink_acg/app/modules/forgetPwd/bindings/forget_pwd_binding.dart';
import 'package:pink_acg/app/modules/forgetPwd/views/forget_pwd_view.dart';
import 'package:pink_acg/app/modules/home/bindings/home_binding.dart';
import 'package:pink_acg/app/modules/home/views/home_view.dart';
import 'package:pink_acg/app/modules/index/bindings/index_binding.dart';
import 'package:pink_acg/app/modules/index/views/index_view.dart';
import 'package:pink_acg/app/modules/login/bindings/login_binding.dart';
import 'package:pink_acg/app/modules/login/views/login_view.dart';
import 'package:pink_acg/app/modules/photoDia/bindings/photo_dia_binding.dart';
import 'package:pink_acg/app/modules/photoDia/views/photo_dia_view.dart';
import 'package:pink_acg/app/modules/post/bindings/post_binding.dart';
import 'package:pink_acg/app/modules/post/views/post_view.dart';
import 'package:pink_acg/app/modules/profile/bindings/profile_binding.dart';
import 'package:pink_acg/app/modules/profile/views/profile_view.dart';
import 'package:pink_acg/app/modules/profileFollow/bindings/profile_follow_binding.dart';
import 'package:pink_acg/app/modules/profileFollow/views/profile_follow_view.dart';
import 'package:pink_acg/app/modules/profilePost/bindings/profile_post_binding.dart';
import 'package:pink_acg/app/modules/profilePost/views/profile_post_view.dart';
import 'package:pink_acg/app/modules/publish/bindings/publish_binding.dart';
import 'package:pink_acg/app/modules/publish/views/publish_view.dart';
import 'package:pink_acg/app/modules/rank/bindings/rank_binding.dart';
import 'package:pink_acg/app/modules/rank/views/rank_view.dart';
import 'package:pink_acg/app/modules/reg/bindings/reg_binding.dart';
import 'package:pink_acg/app/modules/reg/views/reg_view.dart';
import 'package:pink_acg/app/modules/scan/bindings/scan_binding.dart';
import 'package:pink_acg/app/modules/scan/views/scan_view.dart';
import 'package:pink_acg/app/modules/search/bindings/search_binding.dart';
import 'package:pink_acg/app/modules/search/views/search_view.dart';
import 'package:pink_acg/app/modules/setting/bindings/setting_binding.dart';
import 'package:pink_acg/app/modules/setting/views/setting_view.dart';
import 'package:pink_acg/app/modules/userCenter/bindings/user_center_binding.dart';
import 'package:pink_acg/app/modules/userCenter/views/user_center_view.dart';
import 'package:pink_acg/app/modules/userDesc/bindings/user_desc_binding.dart';
import 'package:pink_acg/app/modules/userDesc/views/user_desc_view.dart';
import 'package:pink_acg/app/modules/userEmail/bindings/user_email_binding.dart';
import 'package:pink_acg/app/modules/userEmail/views/user_email_view.dart';
import 'package:pink_acg/app/modules/userInfo/bindings/user_info_binding.dart';
import 'package:pink_acg/app/modules/userInfo/views/user_info_view.dart';
import 'package:pink_acg/app/modules/userPwd/bindings/user_pwd_binding.dart';
import 'package:pink_acg/app/modules/userPwd/views/user_pwd_view.dart';
import 'package:pink_acg/app/modules/userQrcode/bindings/user_qrcode_binding.dart';
import 'package:pink_acg/app/modules/userQrcode/views/user_qrcode_view.dart';
import 'package:pink_acg/app/modules/userUsername/bindings/user_username_binding.dart';
import 'package:pink_acg/app/modules/userUsername/views/user_username_view.dart';
import 'package:pink_acg/app/modules/video/bindings/video_binding.dart';
import 'package:pink_acg/app/modules/video/views/video_view.dart';
import 'package:pink_acg/app/modules/webBrowser/bindings/web_browser_binding.dart';
import 'package:pink_acg/app/modules/webBrowser/views/web_browser_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INDEX;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REG,
      page: () => RegView(),
      binding: RegBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FORGET_PWD,
      page: () => ForgetPwdView(),
      binding: ForgetPwdBinding(),
    ),
    GetPage(
        name: _Paths.INDEX,
        page: () => IndexView(),
        binding: IndexBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.RANK,
        page: () => RankView(),
        binding: RankBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.DYNAMIC,
        page: () => DynamicView(),
        binding: DynamicBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.CONTACT,
        page: () => ContactView(),
        binding: ContactBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.VIDEO,
        page: () => VideoView(),
        binding: VideoBinding(),
        transition: Transition.rightToLeftWithFade,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.POST,
        page: () => PostView(),
        binding: PostBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.SEARCH,
        page: () => SearchView(),
        binding: SearchBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.SCAN,
        page: () => ScanView(),
        binding: ScanBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.USER_CENTER,
        page: () => UserCenterView(),
        binding: UserCenterBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.PROFILE_POST,
        page: () => ProfilePostView(),
        binding: ProfilePostBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.PROFILE_FOLLOW,
        page: () => ProfileFollowView(),
        binding: ProfileFollowBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.SETTING,
        page: () => SettingView(),
        binding: SettingBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.DARK_MODE,
        page: () => DarkModeView(),
        binding: DarkModeBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.PUBLISH,
        page: () => PublishView(),
        binding: PublishBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.USER_INFO,
        page: () => UserInfoView(),
        binding: UserInfoBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.USER_DESC,
        page: () => UserDescView(),
        binding: UserDescBinding(),
        transition: Transition.rightToLeftWithFade,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.USER_EMAIL,
        page: () => UserEmailView(),
        binding: UserEmailBinding(),
        transition: Transition.rightToLeftWithFade,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.USER_PWD,
        page: () => UserPwdView(),
        binding: UserPwdBinding(),
        transition: Transition.rightToLeftWithFade,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.USER_QRCODE,
        page: () => UserQrcodeView(),
        binding: UserQrcodeBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.USER_USERNAME,
        page: () => UserUsernameView(),
        binding: UserUsernameBinding(),
        transition: Transition.rightToLeftWithFade,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.CHAT,
        page: () => ChatView(),
        binding: ChatBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.ABOUT_APP,
        page: () => AboutAppView(),
        binding: AboutAppBinding(),
        transition: Transition.rightToLeftWithFade,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.ABOUT_US,
        page: () => AboutUsView(),
        binding: AboutUsBinding(),
        transition: Transition.rightToLeftWithFade,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.PHOTO_DIA,
        page: () => PhotoDiaView(),
        binding: PhotoDiaBinding(),
        transition: Transition.fadeIn,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.WEB_BROWSER,
        page: () => WebBrowserView(),
        binding: WebBrowserBinding(),
        transition: Transition.rightToLeftWithFade,
        middlewares: [AuthMiddleware()]),
  ];
}
