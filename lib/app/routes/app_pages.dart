import 'package:get/get.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/aboutApp/bindings/about_app_binding.dart';
import '../modules/aboutApp/views/about_app_view.dart';
import '../modules/aboutUs/bindings/about_us_binding.dart';
import '../modules/aboutUs/views/about_us_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/contact/bindings/contact_binding.dart';
import '../modules/contact/views/contact_view.dart';
import '../modules/darkMode/bindings/dark_mode_binding.dart';
import '../modules/darkMode/views/dark_mode_view.dart';
import '../modules/dynamic/bindings/dynamic_binding.dart';
import '../modules/dynamic/views/dynamic_view.dart';
import '../modules/forgetPwd/bindings/forget_pwd_binding.dart';
import '../modules/forgetPwd/views/forget_pwd_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/index/bindings/index_binding.dart';
import '../modules/index/views/index_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/photoDia/bindings/photo_dia_binding.dart';
import '../modules/photoDia/views/photo_dia_view.dart';
import '../modules/post/bindings/post_binding.dart';
import '../modules/post/views/post_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profileFollow/bindings/profile_follow_binding.dart';
import '../modules/profileFollow/views/profile_follow_view.dart';
import '../modules/profilePost/bindings/profile_post_binding.dart';
import '../modules/profilePost/views/profile_post_view.dart';
import '../modules/publish/bindings/publish_binding.dart';
import '../modules/publish/views/publish_view.dart';
import '../modules/rank/bindings/rank_binding.dart';
import '../modules/rank/views/rank_view.dart';
import '../modules/recommend/bindings/recommend_binding.dart';
import '../modules/recommend/views/recommend_view.dart';
import '../modules/reg/bindings/reg_binding.dart';
import '../modules/reg/views/reg_view.dart';
import '../modules/scan/bindings/scan_binding.dart';
import '../modules/scan/views/scan_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/userCenter/bindings/user_center_binding.dart';
import '../modules/userCenter/views/user_center_view.dart';
import '../modules/userDesc/bindings/user_desc_binding.dart';
import '../modules/userDesc/views/user_desc_view.dart';
import '../modules/userEmail/bindings/user_email_binding.dart';
import '../modules/userEmail/views/user_email_view.dart';
import '../modules/userInfo/bindings/user_info_binding.dart';
import '../modules/userInfo/views/user_info_view.dart';
import '../modules/userPwd/bindings/user_pwd_binding.dart';
import '../modules/userPwd/views/user_pwd_view.dart';
import '../modules/userQrcode/bindings/user_qrcode_binding.dart';
import '../modules/userQrcode/views/user_qrcode_view.dart';
import '../modules/userUsername/bindings/user_username_binding.dart';
import '../modules/userUsername/views/user_username_view.dart';
import '../modules/video/bindings/video_binding.dart';
import '../modules/video/views/video_view.dart';
import '../modules/webBrowser/bindings/web_browser_binding.dart';
import '../modules/webBrowser/views/web_browser_view.dart';

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
    GetPage(
      name: _Paths.RECOMMEND,
      page: () => RecommendView(),
      binding: RecommendBinding(),
    ),
  ];
}
