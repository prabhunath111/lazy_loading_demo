import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/constants/app_btn_style.dart';
import 'package:lazy_loading_list/constants/app_strings.dart';
import 'package:lazy_loading_list/features/terms_conditions/controllers/terms_condition_controller.dart';

import 'speaking_sound_wave.dart';
import 'static_sound_wave.dart';

class AddEditBottomSheet extends StatelessWidget {
  final int? index;
  const AddEditBottomSheet({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TermsConditionController termsConditionController = Get.find();
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(12.0),
            topLeft: Radius.circular(12.0)),
        color: Colors.white,
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 44.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<TermsConditionController>(
              builder: (TermsConditionController termsLogic) {
                return TextFormField(
                  controller: termsLogic.termsConditionsTextEditingController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: AppStrings.termsCondition,
                    hintText: AppStrings.termsCondition,
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (termsLogic.getSpeechToText.isNotListening) {
                          termsLogic.resetTranslatedInputText();
                          termsLogic.startListening();
                          Get.dialog(
                            Center(
                              child: Container(
                                width: Get.width * 0.9,
                                constraints: BoxConstraints(
                                    minHeight: 100,
                                    maxHeight: Get.height * 0.9
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () => Get.back(),
                                            icon: const Icon(Icons.clear_rounded)),
                                      ),
                                      GetBuilder<TermsConditionController>(
                                          builder: (TermsConditionController logic) {
                                            if(logic.getSpeechToText.isListening){
                                              return const SpeakingSoundWave();
                                            }
                                            return const StaticSoundWave();
                                          }
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                                        child: DefaultTextStyle(
                                          style: const TextStyle(color: Colors.black),
                                          child: GetBuilder<TermsConditionController>(
                                              builder: (TermsConditionController logic) {
                                                return Text(logic.getLastWord);
                                              }
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if(termsLogic.getSpeechToText.isNotListening) {
                                              termsLogic.addSpeechTextInInputField();
                                            } else {
                                              return;
                                            }
                                          },
                                          style: AppBtnStyle.appElevatedStyle,
                                          child: const Text(
                                            AppStrings.submitBtn,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            barrierDismissible: false,
                            barrierColor: Colors.transparent,
                          );
                        }
                        else {

                        }
                      },
                      icon: const Icon(Icons.mic),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey, width: 0.8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    filled: true,
                    fillColor: Colors.white
                  ),
                );
              }
            ),
             GetBuilder<TermsConditionController>(
               builder: (TermsConditionController logic) {
                 return Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        if(logic.translatedInputText.isNotEmpty) {
                          logic.resetTranslatedInputText();
                        } else {
                          termsConditionController.translateInputText();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),
                        child: Text(logic.translatedInputText.isNotEmpty?AppStrings.hindiHide: AppStrings.hindiView,
                        style: TextStyle(
                            color: Colors.deepPurpleAccent.shade100
                        ),
                        ),
                      )),
            );
               }
             ),
            GetBuilder<TermsConditionController>(
              builder: (TermsConditionController logic) {
                if(logic.translatedInputText.isNotEmpty){
                  return DefaultTextStyle(
                    style: const TextStyle(color: Colors.black),
                    textAlign: TextAlign.left,
                    child: GetBuilder<TermsConditionController>(
                        builder: (TermsConditionController logic) {
                          return Text(logic.translatedInputText);
                        }
                    ),
                  );
                }
                return const SizedBox.shrink();
              }
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    if(index != null){
                      termsConditionController.editTermsCondition(index!);
                    } else {
                      termsConditionController.addNewTermsCondition();
                    }
                    Get.back();
                  },
                  style: AppBtnStyle.appElevatedStyle,
                  child: const Text(AppStrings.confirmBtn),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
