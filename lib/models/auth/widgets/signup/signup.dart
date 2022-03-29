import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/models/auth/auth_constant.dart';
import 'package:flutoo/models/auth/auth_state.dart';
import 'package:flutoo/models/role/role_shema.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/models/user/user_state.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Singup extends ConsumerStatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends ConsumerState<Singup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController pseudo = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  bool termes = false;
  String testemail = '';
  String testpassword = '';

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  /// inscription user
  Future<void> inscritionAuth(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      /// petit load à la connexion
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // inscription user firebase
      try {
        /// creation auth
        UserCredential user =
            await ref.watch(authState).createAuth(email, password);

        /// variable userShema
        UserSchema userSchema = UserSchema(
          uid: user.user!.uid,
          email: email.text.trim(),
          pseudo: pseudo.text,
          firstName: firstName.text,
          lastName: lastName.text,
          termes: termes,
          avatar: '',
          role: RoleSchema(libelle: 'public', description: 'utilisateur simple')
              .toMap(),
        );

        /// ajouter un user bdd
        await ref.watch(userState).addUser(userSchema);

        /// navigé vers la todo
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushNamed(context, Routes().todo);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          NotifMessage(
            text: AuthConstant.inscriptionUserPasswordError,
            error: true,
          ).notification(context);
          throw Exception(AuthConstant.inscriptionUserPasswordError);
        } else if (e.code == 'email-already-in-use') {
          NotifMessage(
            text: AuthConstant.inscriptionUserEmailError,
            error: true,
          ).notification(context);
          throw Exception(AuthConstant.inscriptionUserEmailError);
        }
      }

      // ajouter un User dans notre bdd

      // rest le form
      _formKey.currentState!.reset();
      email.clear();
      password.clear();

      // norification succés
      NotifMessage(
        text: AuthConstant.inscriptionUserMessageSucces,
        error: true,
      ).notification(context);
    } else {
      // norification d'erreur
      NotifMessage(
        text: AuthConstant.inscriptionError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 0.0),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// title de la page
                  Text(
                    AuthConstant.titlePageCreate!,
                    style: const TextStyle(fontSize: 36.0),
                  ),

                  /// input email
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: email,
                      onChanged: (value) {
                        setState(() {
                          testemail = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: AuthConstant.labelCreateInputEmail,
                      ),
                      validator: (value) => Validator.validateEmail(
                        textError: Validator.inputConnexionEmail,
                        value: value,
                      ),
                    ),
                  ),

                  /// input password
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: password,
                      onChanged: (value) {
                        setState(() {
                          testpassword = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: AuthConstant.labelCreateInputPassword,
                      ),
                      validator: (value) => Validator.validatePassword(
                        textError: Validator.inputConnexionPassword,
                        value: value,
                      ),
                    ),
                  ),

                  /// input pseudo
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: pseudo,
                      decoration: InputDecoration(
                        labelText: AuthConstant.labelInputPseudo,
                      ),
                    ),
                  ),

                  /// input lastName
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: lastName,
                      decoration: InputDecoration(
                        labelText: AuthConstant.labelInputLastName,
                      ),
                    ),
                  ),

                  /// input firstName
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10.0),
                    child: TextFormField(
                      controller: firstName,
                      decoration: InputDecoration(
                        labelText: AuthConstant.labelInputFirstName,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: CheckboxListTile(
                      title: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes().conditions);
                        },
                        child: const Text(
                          'Accepter les conditions générales',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      value: termes,
                      onChanged: (newValue) {
                        setState(() {
                          termes = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ),

                  /// btn create user
                  ElevatedButton(
                    onPressed: termes && testemail != '' && testpassword != ''
                        ? () async {
                            await inscritionAuth(context);
                          }
                        : null,
                    child: Text(AuthConstant.btnCreateUser!),
                  ),

                  /// text info formulaire
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AuthConstant.infoFormCreate!,
                        style: const TextStyle(fontSize: 11.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
