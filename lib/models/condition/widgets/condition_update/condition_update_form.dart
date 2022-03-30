import 'package:flutoo/models/condition/condition_constant.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/models/condition/condition_state.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ConditionUpdateForm extends ConsumerStatefulWidget {
  ConditionSchema conditionSelect;

  ConditionUpdateForm({Key? key, required this.conditionSelect})
      : super(key: key);

  @override
  _ConditionUpdateFormState createState() => _ConditionUpdateFormState();
}

class _ConditionUpdateFormState extends ConsumerState<ConditionUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  String? inputTitle;

  void updateCondition(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      /// creation de la condition
      ref
          .watch(conditionState)
          .updateTitleCondition(inputTitle!, widget.conditionSelect);

      /// message de confirmation
      NotifMessage(
        text: ConditionConstant.updateMessageSucces,
        error: false,
      ).notification(context);
    } else {
      /// message d'erreur
      NotifMessage(
        text: ConditionConstant.updateMessageError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// init valeur input
    inputTitle = widget.conditionSelect.title!;

    return Container(
      margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// input title condition
            InputCustom(
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              initialValue: inputTitle,
              labelText: ConditionConstant.updateLabelInputTitle,
              validator: (value) => Validator.validatorInputTextBasic(
                textError: Validator.inputConditionTitle,
                value: value,
              ),
              onChange: (value) => inputTitle = value,
            ),

            /// btn modifier
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => updateCondition(context),
                child: Text(ConditionConstant.updateBtn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
