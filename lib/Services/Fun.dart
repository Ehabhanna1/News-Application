import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';


class Fun{
 static Future<void> openLink(String Link) async {
    var urllink = Link;
    if (await canLaunch(urllink)) {
      await launch(urllink);
    } else {
      await launch(urllink);
    }
  }
 static Future<void> shareLink(String Link) async {
    var urllink = Link;
    Share.share(Link);
  }
 static Future<void> copyLink(String Link) async {
    var urllink = Link;
    FlutterClipboard.copy(Link).then((value) => print('copied'));
  }






}