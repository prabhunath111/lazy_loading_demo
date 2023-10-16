import 'package:flutter/material.dart';
import 'package:lazy_loading_list/constants/app_images.dart';

class SpeakingSoundWave extends StatelessWidget {
  const SpeakingSoundWave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.runningSoundWave);
  }
}
