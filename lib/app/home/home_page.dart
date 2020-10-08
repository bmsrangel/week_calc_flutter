import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/utils/utils.dart';
import 'components/clear_button_widget.dart';
import 'components/custom_text_field_widget.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<HomeController>().dayFocus.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Provider.of<HomeController>(context);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: this._formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Set year?"),
                    Switch(
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        _controller.setEnableYearSelection(value);
                      },
                      value:
                          context.watch<HomeController>().enableYearSelection,
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextFieldWidget(
                      controller: _controller.day$,
                      focusNode: _controller.dayFocus,
                      hintText: "DD",
                      validator: Utils.validateDay,
                      onChanged: (value) {
                        if (value.length == 2) {
                          _controller.monthFocus.nextFocus();
                        }
                      },
                    ),
                    Container(
                      width: 50.0,
                      alignment: Alignment.center,
                      child: Text(
                        '/',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    CustomTextFieldWidget(
                      controller: _controller.month$,
                      focusNode: _controller.monthFocus,
                      hintText: "MM",
                      validator: Utils.validateMonth,
                      onChanged: (value) {
                        if (!_controller.enabled) {
                          if (value.length == 2 &&
                              this._formKey.currentState.validate()) {
                            _controller.monthFocus.unfocus();
                            _controller.setWeekNumber(
                                _controller.day$.text, _controller.month$.text);
                          }
                        } else {
                          if (value.length == 2) {
                            _controller.yearFocus.nextFocus();
                          }
                        }
                      },
                    ),
                    Container(
                      width: 50.0,
                      alignment: Alignment.center,
                      child: Text(
                        '/',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    CustomTextFieldWidget(
                      controller: _controller.year$,
                      focusNode: _controller.yearFocus,
                      hintText: "YYYY",
                      maxLength: 4,
                      validator: Utils.validateYear,
                      enabled:
                          context.watch<HomeController>().enableYearSelection,
                      onChanged: (value) {
                        if (value.length >= 4 &&
                            this._formKey.currentState.validate()) {
                          _controller.monthFocus.unfocus();
                          _controller.setWeekNumber(
                              _controller.day$.text, _controller.month$.text);
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                const Divider(thickness: 3.0),
                const SizedBox(height: 20.0),
                Text(
                  "Week ${context.watch<HomeController>().weekNumber ?? "Number"}",
                  style: TextStyle(fontSize: 32.0),
                ),
                const SizedBox(height: 30.0),
                ClearButtonWidget(
                  buttonText: "CLEAR",
                  onPressed: _controller.resetFields,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
