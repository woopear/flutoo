import 'package:flutoo/models/article/widgets/article_create/article_create.dart';
import 'package:flutoo/models/article/widgets/article_list/article_list.dart';
import 'package:flutoo/models/condition/condition_constant.dart';
import 'package:flutoo/models/condition/condition_state.dart';
import 'package:flutoo/models/condition/widgets/condition_update/condition_update_form.dart';
import 'package:flutoo/widget_shared/button_closed/button_closed.dart';
import 'package:flutoo/widget_shared/text_button_icon/text_button_icon.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConditionUpdate extends ConsumerStatefulWidget {
  Function() openCloseUpdateCondition;

  ConditionUpdate({
    Key? key,
    required this.openCloseUpdateCondition,
  }) : super(key: key);

  @override
  _ConditionUpdateState createState() => _ConditionUpdateState();
}

class _ConditionUpdateState extends ConsumerState<ConditionUpdate> {
  bool seeArticleCreate = false;

  /// afficher / cacher volet de creation article
  void openCloseArticleCreate() {
    setState(() {
      seeArticleCreate = !seeArticleCreate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(conditionSelect).when(
          data: (conditionSelect) {
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
                          conditionSelect.title!,
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

                  /// title de la partie de la list des articles
                  Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      ConditionConstant.titleListArticles,
                      style: const TextStyle(fontSize: 28.0),
                    ),
                  ),

                  /// btn affiche/cache Article create
                  Container(
                    margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButtonIcon(
                        seeAddCondition: seeArticleCreate,
                        onPressed: () => openCloseArticleCreate(),
                        textbtn1: ConditionConstant.btnOpenCreateArticle,
                        textbtn2: ConditionConstant.btnCloseCreateArticle,
                      ),
                    ),
                  ),

                  /// creation d'articles
                  seeArticleCreate
                      ? ArticleCreate(
                          conditionSelect: conditionSelect,
                          openCloseArticleCreate: () =>
                              openCloseArticleCreate(),
                        )
                      : Container(),

                  /// list des articles
                  ArticleList(
                    conditionSelect: conditionSelect,
                  ),
                ],
              ),
            );
          },
          error: (error, stack) => const WaitingError(),
          loading: () => const WaitingData(),
        );
  }
}
