import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/all_feedback/bindings/all_feedback_binding.dart';
import '../modules/all_feedback/views/all_feedback_view.dart';
import '../modules/event/bindings/event_binding.dart';
import '../modules/event/views/event_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/help_center/bindings/help_center_binding.dart';
import '../modules/help_center/views/help_center_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_main/bindings/home_main_binding.dart';
import '../modules/home_main/views/home_main_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mymenu/bindings/mymenu_binding.dart';
import '../modules/mymenu/views/mymenu_view.dart';
import '../modules/notifics/bindings/notifics_binding.dart';
import '../modules/notifics/views/notifics_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/shop/bindings/shop_binding.dart';
import '../modules/shop/views/shop_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/terms/bindings/terms_binding.dart';
import '../modules/terms/views/terms_view.dart';

// Tambahkan jika ada tambahan lainnya seperti PrivacyPolicy

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: _Paths.SPLASH,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: _Paths.ONBOARDING,
        page: () => const OnboardingView(),
        binding: OnboardingBinding()),
    GetPage(
        name: _Paths.LOGIN,
        page: () => const LoginView(),
        binding: LoginBinding()),
    GetPage(
        name: _Paths.REGISTER,
        page: () => const RegisterView(),
        binding: RegisterBinding()),
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: _Paths.HOME_MAIN,
        page: () => const HomeMainView(),
        binding: HomeMainBinding()),
    GetPage(
        name: _Paths.MYMENU,
        page: () => const MyMenuView(),
        binding: MymenuBinding()),
    GetPage(
        name: _Paths.NOTIFICS,
        page: () => const NotificsView(),
        binding: NotificsBinding()),
    GetPage(
        name: _Paths.ABOUT,
        page: () => const AboutView(),
        binding: AboutBinding()),
    GetPage(
        name: _Paths.ACCOUNT,
        page: () => const AccountView(),
        binding: AccountBinding()),
    GetPage(
        name: _Paths.ALL_FEEDBACK,
        page: () => const AllFeedbackView(),
        binding: AllFeedbackBinding()),
    GetPage(
        name: _Paths.EVENT,
        page: () => const EventView(),
        binding: EventBinding()),
    GetPage(
        name: _Paths.SHOP,
        page: () => const ShopView(),
        binding: ShopBinding()),
    GetPage(
        name: _Paths.FORGOT_PASSWORD,
        page: () => const ForgotPasswordView(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: _Paths.RESET_PASSWORD,
        page: () => const ResetPasswordView(),
        binding: ResetPasswordBinding()),
    GetPage(
        name: _Paths.HELP_CENTER,
        page: () => const HelpCenterView(),
        binding: HelpCenterBinding()),
    GetPage(
        name: _Paths.TERMS,
        page: () => const TermsView(),
        binding: TermsBinding()),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
  ];
}
