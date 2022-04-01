import 'package:flutoo/models/condition/condition_constant.dart';
import 'package:flutoo/models/condition/condition_state.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ConditionCreateForm extends ConsumerStatefulWidget {
  Function() openCloseAddCondition;
  ConditionCreateForm({Key? key, required this.openCloseAddCondition})
      : super(key: key);

  @override
  _ConditionCreateFormState createState() => _ConditionCreateFormState();
}

class _ConditionCreateFormState extends ConsumerState<ConditionCreateForm> {
  final _formKey = GlobalKey<FormState>();
  String? inputTitle;

  void createCondition(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      /// creation de la condition
      ref.watch(conditionState).addCondition(inputTitle!);

      /// reset variable pour input
      setState(() => {
            inputTitle = '',
          });

      /// reset form
      _formKey.currentState!.reset();
      widget.openCloseAddCondition();

      /// message de confirmation
      NotifMessage(
        text: ConditionConstant.createMessageSucces,
        error: false,
      ).notification(context);
    } else {
      /// message d'erreur
      NotifMessage(
        text: ConditionConstant.createMessageError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                /// input
                Expanded(
                  child: InputCustom(
                    initialValue: inputTitle,
                    labelText: ConditionConstant.createLabelInputTitle,
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: Validator.inputConditionTitle,
                      value: value,
                    ),
                    onChange: (value) => inputTitle = value,
                  ),
                ),

                /// btn valider
                Container(
                  margin: const EdgeInsets.only(left: 30.0),
                  child: ElevatedButton(
                    onPressed: () => createCondition(context),
                    child: Text(ConditionConstant.createBtn),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
