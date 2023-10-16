import 'package:flutter/material.dart';
import 'package:lazy_loading_list/constants/app_images.dart';

class StaticSoundWave extends StatelessWidget {
  const StaticSoundWave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.staticSoundWave);
  }
}
