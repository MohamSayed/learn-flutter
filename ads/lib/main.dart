import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
void main() => runApp(new MyApp());

MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: new DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = new BannerAd(
  adUnitId: BannerAd.testAdUnitId,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = new InterstitialAd(
  adUnitId: InterstitialAd.testAdUnitId,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
  void initState() { 
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-1527015981726255~6399611108");
  }
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    myBanner..load()..show(anchorOffset: 0.0, anchorType: AnchorType.bottom,);
    return MaterialApp(
      home: Material(
        child: Container(
          color: Colors.greenAccent,
          child: InkWell(child: Center(child: Text("Text")),
          )
        )
      ),
    );
  }
}

