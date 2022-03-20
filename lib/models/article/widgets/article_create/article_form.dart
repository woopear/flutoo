import 'package:flutoo/models/article/article_provider.dart';
import 'package:flutoo/models/article/article_schema.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ArticleForm extends StatefulWidget {
  Function()? switchForSeeArticleForm;
  bool? seeArticleForm;
  String? idCondition;

  ArticleForm({
    Key? key,
    required this.switchForSeeArticleForm,
    required this.seeArticleForm,
    required this.idCondition,
  }) : super(key: key);

  @override
  State<ArticleForm> createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  final _formKey = GlobalKey<FormState>();
  String? inputTitle;

  /// liste des variables relier au input de text de l'article
  List<TextEditingController> listText = [TextEditingController()];

  bool seeCloseTexarea() => listText.length > 1;

  @override
  void dispose() {
    // reset les textarea apres changement de widget
    listText.map((e) => e.dispose());
    super.dispose();
  }

  /// creation de l'article
  void createArticle(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      /// creation de l'article + content de l'article creer
      final data = ArticleSchema(title: inputTitle);
      context
          .read<ArticleProvider>()
          .addArticle(widget.idCondition!, data, listText);

      /// reset inputs
      setState(() => {
            inputTitle = '',
            listText = [TextEditingController()],
          });
      _formKey.currentState!.reset();

      /// fermeture du volet
      widget.switchForSeeArticleForm!();

      /// widget message succes
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Article ajouter')),
      );
    } else {
      /// widget message error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur est survenue')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// input title article
          InputCustom(
            margin: const EdgeInsets.only(bottom: 20.0, top: 30.0),
            labelText: "titre de l'article",
            validator: (value) => Validator.validatorInputTextBasic(
              textError: Validator.titleArticle,
              value: value,
            ),
            onChange: (value) => inputTitle = value,
          ),

          /// texarea pour text du content
          Column(
            children: listText.map(
              (e) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      /// supprimer le textarea
                      seeCloseTexarea()
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  setState(() => {
                                        listText.remove(e),
                                      });
                                },
                                icon: const Icon(Icons.close),
                              ),
                            )
                          : Container(),

                      /// textarea content
                      TextField(
                        controller: e,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          labelText: "Ecriver votre texte",
                          alignLabelWithHint: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),

          /// btn ajoute un text à l'article
          addContentArticle(),

          /// btn form
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => createArticle(context),
                child: const Text('Enregistrer'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// btn ajoute un content à l'article
  Widget addContentArticle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: () {
            setState(() => {
                  listText.add(TextEditingController()),
                });
          },
          icon: const Icon(Icons.add),
          label: const Text(
            'Ajouter un texte',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
