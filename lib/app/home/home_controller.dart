import 'package:flutter/material.dart';

import '../../shared/utils/utils.dart';

class HomeController extends ChangeNotifier {
  final TextEditingController day$ = TextEditingController();
  final TextEditingController month$ = TextEditingController();
  final TextEditingController year$ = TextEditingController();
  final FocusNode dayFocus = FocusNode();
  final FocusNode monthFocus = FocusNode();
  final FocusNode yearFocus = FocusNode();

  final int _currentYear = DateTime.now().year;
  int weekNumber;
  bool enableYearSelection = false;

  HomeController() {
    this.year$.text = this._currentYear.toString();
  }

  void setWeekNumber(String day, String month) {
    weekNumber = Utils.getWeekNumberFromDate(
      DateTime(
        enableYearSelection ? int.tryParse(this.year$.text) : this._currentYear,
        int.tryParse(month),
        int.tryParse(day),
      ),
    );
    notifyListeners();
  }

  void setEnableYearSelection(bool value) {
    this.enableYearSelection = value;
    if (!this.enableYearSelection) {
      this.year$.text = this._currentYear.toString();
    } else {
      this.year$.clear();
      if (this.day$.text.isNotEmpty && this.month$.text.isNotEmpty) {
        this.yearFocus.canRequestFocus = true;
        this.yearFocus.requestFocus();
      }
    }
    notifyListeners();
  }

  bool get enabled => this.enableYearSelection;

  void resetFields() {
    this.day$.clear();
    this.month$.clear();
    if (this.enableYearSelection) {
      this.year$.clear();
    }
    this.dayFocus.requestFocus();
    this.weekNumber = null;
    notifyListeners();
  }

  @override
  void dispose() {
    this.day$.dispose();
    this.month$.dispose();
    this.year$.dispose();
    this.dayFocus.dispose();
    this.monthFocus.dispose();
    this.yearFocus.dispose();
    super.dispose();
  }
}
