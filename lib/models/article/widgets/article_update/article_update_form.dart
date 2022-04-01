import 'package:flutoo/models/article/article_constant.dart';
import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/models/article/article_state.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ArticleUpdateForm extends ConsumerStatefulWidget {
  ArticleSchema articleSelect;
  ConditionSchema conditionSelect;

  ArticleUpdateForm({
    Key? key,
    required this.articleSelect,
    required this.conditionSelect,
  }) : super(key: key);

  @override
  _ArticleUpdateFormState createState() => _ArticleUpdateFormState();
}

class _ArticleUpdateFormState extends ConsumerState<ArticleUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  String? inputTitle;

  void updateArticle(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      /// modification titre article
      ref.watch(articleState).updateTitleArticle(
          widget.conditionSelect.id!, widget.articleSelect.id!, inputTitle!);

      /// message de confirmation
      NotifMessage(
        text: ArticleConstant.updateMessageSucces,
        error: false,
      ).notification(context);
    } else {
      /// message d'erreur
      NotifMessage(
        text: ArticleConstant.updateMessageError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// init input title
    inputTitle = widget.articleSelect.title;

    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// input title
            InputCustom(
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              initialValue: inputTitle,
              labelText: ArticleConstant.updateInputTitle,
              validator: (value) => Validator.validatorInputTextBasic(
                textError: Validator.inputArticleTitle,
                value: value,
              ),
              onChange: (value) => inputTitle = value,
            ),

            /// btn modifier article
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => updateArticle(context),
                child: Text(ArticleConstant.updateBtn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
