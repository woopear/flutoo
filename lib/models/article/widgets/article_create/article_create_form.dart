import 'package:flutoo/models/article/article_constant.dart';
import 'package:flutoo/models/article/article_state.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ArticleCreateForm extends ConsumerStatefulWidget {
  Function() openCloseArticleCreate;
  ConditionSchema conditionSelect;

  ArticleCreateForm({
    Key? key,
    required this.openCloseArticleCreate,
    required this.conditionSelect,
  }) : super(key: key);

  @override
  _ArticleCreateFormState createState() => _ArticleCreateFormState();
}

class _ArticleCreateFormState extends ConsumerState<ArticleCreateForm> {
  final _formKey = GlobalKey<FormState>();
  String? inputTitle;

  /// creation article
  void createArticle(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      /// creation article
      ref
          .watch(articleState)
          .addArticle(inputTitle!, widget.conditionSelect.id!);

      /// reset variable pour input
      setState(() => {
            inputTitle = '',
          });

      /// reset form
      _formKey.currentState!.reset();
      widget.openCloseArticleCreate();

      /// message de confirmation
      NotifMessage(
        text: ArticleConstant.createMessageSucces,
        error: false,
      ).notification(context);
    } else {
      /// message d'erreur
      NotifMessage(
        text: ArticleConstant.createMessageError,
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
            /// input title
            InputCustom(
              margin: const EdgeInsets.only(bottom: 20.0),
              initialValue: inputTitle,
              labelText: ArticleConstant.createLabelInputTitle,
              validator: (value) => Validator.validatorInputTextBasic(
                textError: Validator.inputConditionTitle,
                value: value,
              ),
              onChange: (value) => inputTitle = value,
            ),

            /// btn creer article
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => createArticle(context),
                child: Text(ArticleConstant.createBtn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
