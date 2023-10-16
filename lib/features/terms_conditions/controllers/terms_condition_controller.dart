import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import '../../../constants/local_data.dart';
import '../models/terms_condition_model.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class TermsConditionController extends GetxController {

  ScrollController scrollController = ScrollController();

  final TextEditingController termsConditionsTextEditingController = TextEditingController();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  String _lastWords = '';
  String _translatedInputText = '';


  List<TermsConditionsModel> _termsConditionList = <TermsConditionsModel>[];
  late final TranslateLanguage sourceLanguage;
  late final TranslateLanguage targetLanguage;

  final OnDeviceTranslator _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: TranslateLanguage.english,
    targetLanguage: TranslateLanguage.hindi,
  );

  ///getters
  List<TermsConditionsModel> get getAllTermsConditionList => _termsConditionList;
  stt.SpeechToText get getSpeechToText => _speechToText;
  String get getLastWord => _lastWords;
  String get translatedInputText => _translatedInputText;

  @override
  void onInit() async {
    // TODO: implement onInit
    scrollController.addListener(() {

    });
    _termsConditionList = termsConditionsModelFromJson(jsonEncode(LocalData.termsCondition));
    /// This has to happen only once per app
      await _speechToText.initialize();
      update();
    super.onInit();
  }

  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    ///This is working as append
    _lastWords = result.recognizedWords;
    update();
  }

  void addSpeechTextInInputField() {
    if(_lastWords.isNotEmpty){
      termsConditionsTextEditingController.text = _lastWords;
    }
    Get.back();
  }

  /// Each time to start a speech recognition session
  void startListening() async {
    _lastWords = '';
    await _speechToText.listen(
        onResult: _onSpeechResult, localeId: 'en_IN', pauseFor: const Duration(seconds: 5));
    update();
  }

  void addNewTermsCondition() {
    _termsConditionList.add(TermsConditionsModel(
      value: termsConditionsTextEditingController.text.trim(),
      hindi: false,
      hindiValue: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      id: _termsConditionList.last.id! + 1
    ));
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    update();
  }

  void editTermsCondition(int index) {
    _termsConditionList[index] = TermsConditionsModel(
        value: termsConditionsTextEditingController.text.trim(),
        hindi: false,
        hindiValue: '',
        createdAt: _termsConditionList[index].createdAt,
        updatedAt: DateTime.now(),
        id: _termsConditionList[index].id!
    );
    update();
  }

  Future<void> updateTermsLanguage(int index, bool newVal) async {
    if(newVal) {
      getAllTermsConditionList[index].hindiValue = await _onDeviceTranslator.translateText(getAllTermsConditionList[index].value!);
      getAllTermsConditionList[index].hindi = newVal;
    } else {
      getAllTermsConditionList[index].hindi = newVal;
      getAllTermsConditionList[index].hindiValue = '';
    }
    update();
  }

  Future<void> translateInputText() async {
    if(termsConditionsTextEditingController.text.trim().isNotEmpty) {
      _translatedInputText = await _onDeviceTranslator.translateText(termsConditionsTextEditingController.text);
      update();
    }
  }
  void resetTranslatedInputText() {
    _translatedInputText = '';
    update();
  }

}