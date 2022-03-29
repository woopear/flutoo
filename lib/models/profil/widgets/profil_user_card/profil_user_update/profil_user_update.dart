import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/models/user/user_state.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:woo_widget_input/woo_widget_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilUserUpdate extends ConsumerStatefulWidget {
  void Function()? closedUpdated;

  ProfilUserUpdate({
    Key? key,
    required this.closedUpdated,
  }) : super(key: key);

  @override
  _ProfilUserUpdateState createState() => _ProfilUserUpdateState();
}

class _ProfilUserUpdateState extends ConsumerState<ProfilUserUpdate> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController pseudo = TextEditingController();
  late UserSchema userUpdateData;

  @override
  void dispose() {
    email.dispose();
    firstName.dispose();
    lastName.dispose();
    pseudo.dispose();
    super.dispose();
  }

  /// update user
  void updateUser(BuildContext context, UserSchema userUpdateFile) {
    UserSchema userUpdate = userUpdateFile;
    if (_formKey.currentState!.validate()) {
      /// on assigne tous les champ dans la variable userUpdate
      userUpdate.email = email.text.trim();
      userUpdate.firstName = firstName.text.trim();
      userUpdate.lastName = lastName.text.trim();
      userUpdate.pseudo = pseudo.text.trim();

      ref.watch(userState).updateUser(userUpdate.id!, userUpdate);

      /// ferme le volet update user
      widget.closedUpdated!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userCurrent);

    return Container(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      width: 500,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              child: TextFormField(
                controller: firstName,
                initialValue: user?.firstName!,
                decoration: const InputDecoration(
                  labelText: 'Nom : ',
                ),
                style: const TextStyle(
                  fontSize: 22,
                ),
                validator: (value) => Validator.validatorInputTextBasic(
                  textError: Validator.inputFirstName,
                  value: value,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: InputCustom(
                initialValue: user?.lastName!,
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                label: const Text(
                  'Prénom : ',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                onChange: (value) => lastName = value,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: InputCustom(
                initialValue: user?.pseudo!,
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                label: const Text(
                  'Pseudo : ',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                onChange: (value) => pseudo = value,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              margin: const EdgeInsets.only(top: 30),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Email : ',
                ),
                style: const TextStyle(
                  fontSize: 22,
                ),
                validator: (value) => Validator.validateEmail(
                  textError: Validator.inputConnexionEmail,
                  value: value,
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () => {
                  /// on met le changement de donnée dans une variable
                  userUpdateData = user!,
                  updateUser(context, userUpdateData),
                },
                child: const Text(
                  'Valider',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
