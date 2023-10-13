import 'package:flutter/material.dart';
import 'package:yj_gromore_sdk/callback/gromore_splash_callback.dart';
import 'package:yj_gromore_sdk/config/gromore_splash_config.dart';
import 'package:yj_gromore_sdk/view/gromore_splash_view.dart';
import 'package:flutter_gromore_example/config/config.dart';

class CustomSplash extends StatefulWidget {
  const CustomSplash({Key? key}) : super(key: key);

  @override
  State<CustomSplash> createState() => _CustomSplashState();
}

class _CustomSplashState extends State<CustomSplash> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("自定义布局的开屏广告"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GromoreSplashView(
              creationParams: GromoreSplashConfig(
                  adUnitId: GroMoreAdConfig.splashId, height: height - 80),
              callback: GromoreSplashCallback(onAdEnd: () {
                Navigator.pop(context);
              }),
            ),
          ),
          const SizedBox(
            height: 80,
            child: Center(child: Text("牛小二招聘")),
          )
        ],
      ),
    );
  }
}
