import 'package:flutoo/models/article/article_provider.dart';
import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class ArticleForm extends StatefulWidget {
  void Function()? switchForSeeArticleForm;
  ArticleForm({Key? key, this.switchForSeeArticleForm}) : super(key: key);

  @override
  State<ArticleForm> createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  final _formKey = GlobalKey<FormState>();
  String? inputTitle;

  /// liste des variables relier au input de text de l'article
  List<TextEditingController> listTexte = [TextEditingController()];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    listTexte.map((e) => e.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cond = context.watch<ConditionProvider>().condition;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// input title article
          InputCustom(
            margin: const EdgeInsets.only(bottom: 20.0),
            labelText: "titre de l'article",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un titre valide';
              }
              return null;
            },
            onChange: (value) => inputTitle = value,
          ),

          /// btn ajoute un text à l'article
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  setState(() => {
                        listTexte.add(TextEditingController()),
                      });
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Ajouter un texte',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),

          /// texarea pour text du content
          Column(
            children: listTexte.map((e) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: e,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: "Ecriver votre texte",
                    alignLabelWithHint: true,
                  ),
                ),
              );
            }).toList(),
          ),

          /// btn form
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    /// ajout de l'article
                    context
                        .read<ArticleProvider>()
                        .addArticle(cond!['id'], inputTitle, listTexte);

                    /// reset inputs
                    setState(() => {
                          inputTitle = '',
                          listTexte = [TextEditingController()],
                        });
                    _formKey.currentState!.reset();
                    widget.switchForSeeArticleForm!();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Article ajouter')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Une erreur est survenue')),
                    );
                  }
                },
                child: const Text('Enregistrer'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
