import 'package:the_best_food/data/model/response/language_model.dart';
import 'package:the_best_food/util/app_constants.dart';
import 'package:flutter/material.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return AppConstants.languages;
  }
}
