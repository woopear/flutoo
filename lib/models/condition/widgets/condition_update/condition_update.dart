import 'package:flutoo/models/article/widgets/article_create/article_create.dart';
import 'package:flutoo/models/article/widgets/article_list/article_list.dart';
import 'package:flutoo/models/condition/condition_constant.dart';
import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/condition_schema.dart';
import 'package:flutoo/models/condition/widgets/condition_update/condition_update_form.dart';
import 'package:flutoo/widget_shared/button_closed/button_closed.dart';
import 'package:flutoo/widget_shared/text_button_icon/text_button_icon.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConditionUpdate extends StatefulWidget {
  Function() openCloseUpdateCondition;

  ConditionUpdate({
    Key? key,
    required this.openCloseUpdateCondition,
  }) : super(key: key);

  @override
  State<ConditionUpdate> createState() => _ConditionUpdateState();
}

class _ConditionUpdateState extends State<ConditionUpdate> {
  bool seeArticleCreate = false;

  /// afficher / cacher volet de creation article
  void openCloseArticleCreate() {
    setState(() {
      seeArticleCreate = !seeArticleCreate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.watch<ConditionProvider>().conditionSelected,
      builder: (BuildContext context, AsyncSnapshot<ConditionSchema> snapshot) {
        /// error
        if (snapshot.hasError) {
          return const WaitingError();
        }

        /// en attente
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        }

        final conditionSelect = snapshot.data;

        return Container(
          margin: const EdgeInsets.only(top: 70.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              /// title de la condition + btn close update
              Row(
                children: [
                  /// title
                  Expanded(
                    child: Text(
                      conditionSelect!.title!,
                      style: const TextStyle(fontSize: 28.0),
                    ),
                  ),

                  /// btn close update
                  ButtonClosed(
                    onPressed: () => widget.openCloseUpdateCondition(),
                  ),
                ],
              ),

              /// form update title condition
              ConditionUpdateForm(
                conditionSelect: conditionSelect,
              ),

              /// btn affiche/cache Article create
              Align(
                alignment: Alignment.centerLeft,
                child: TextButtonIcon(
                  seeAddCondition: seeArticleCreate,
                  onPressed: () => openCloseArticleCreate(),
                  textbtn1: ConditionConstant.btnOpenCreateArticle,
                  textbtn2: ConditionConstant.btnCloseCreateArticle,
                ),
              ),

              /// creation d'articles
              seeArticleCreate
                  ? ArticleCreate(
                      conditionSelect: conditionSelect,
                      openCloseArticleCreate: () => openCloseArticleCreate(),
                    )
                  : Container(),

              /// title de la partie de la list des articles
              Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: Text(
                  ConditionConstant.titleListArticles,
                  style: const TextStyle(fontSize: 28.0),
                ),
              ),

              /// list des articles
              ArticleList(
                conditionSelect: conditionSelect,
              ),
            ],
          ),
        );
      },
    );
  }
}
