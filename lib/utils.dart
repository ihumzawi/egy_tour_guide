import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void openGoogleMap({required String latLong}) async {
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (latLong == null) {
      latLong = '';
    }
    String url = 'https://www.google.com/maps/search/?api=1&query=$latLong';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'لقد حدث خطأ اثناء الارسال';
    }
  }

  static void openWhatsApp(
      {required String numper, String text = 'مرحبا'}) async {
    String url = 'https://wa.me/$numper?text=$text';

    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'لقد حدث خطأ اثناء الارسال';
    }
  }

  static void mailTo({required String email}) async {
    String url = 'mailto:$email?';

    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'لقد حدث خطأ اثناء ارسال الايميل';
    }
  }

  static void callTo({required String numper}) async {
    String url = 'tel://$numper';

    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'لقد حدث خطأ اثناء ارسال الاتصال';
    }
  }
}
