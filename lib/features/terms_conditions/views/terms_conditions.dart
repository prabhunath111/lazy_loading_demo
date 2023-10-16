import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/constants/app_btn_style.dart';
import 'package:lazy_loading_list/constants/app_strings.dart';
import 'package:lazy_loading_list/features/terms_conditions/controllers/terms_condition_controller.dart';

import '../models/terms_condition_model.dart';
import 'widgets/add_edit_bottom_sheet.dart';


class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  final TermsConditionController termsConditionController = Get.put(TermsConditionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.termsConditionAppBar),
      ),
      body: GetBuilder<TermsConditionController>(
        builder: (termsLogic) {
          return ListView.builder(
              controller: termsLogic.scrollController,
              itemCount: termsLogic.getAllTermsConditionList.length,
              itemBuilder: (BuildContext _, int index){
                TermsConditionsModel data = termsLogic.getAllTermsConditionList[index];
                return InkWell(
              onTap: () {
                termsLogic.termsConditionsTextEditingController.text = data.value!;
                termsLogic.resetTranslatedInputText();
                  Get.bottomSheet(AddEditBottomSheet(index: index));
                },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.value!),
                      if(data.hindi!)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(data.hindiValue!),
                        ),
                      Align(
                        alignment: Alignment.bottomRight,
                          child: InkWell(
                              onTap: () => termsConditionController.updateTermsLanguage(index, !data.hindi!),
                              child: Text(data.hindi! ? AppStrings.readInEng : AppStrings.readInHin,
                              style: TextStyle(
                                color: Colors.deepPurpleAccent.shade100
                              ),
                              ),),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        }
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () {
            termsConditionController.termsConditionsTextEditingController.clear();
            termsConditionController.resetTranslatedInputText();
            Get.bottomSheet(
              const AddEditBottomSheet(),
            );
          },
        style: AppBtnStyle.appElevatedStyle,
          child: const Text(
            AppStrings.addMore
          ),
      ),
    );
  }

}
