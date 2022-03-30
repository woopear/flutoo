import 'package:flutoo/models/user/user_constant.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/models/user/user_state.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String firstName = '';
  String lastName = '';
  String pseudo = '';
  late UserSchema userUpdateData;

  @override

  /// update user
  void updateUser(BuildContext context, UserSchema userUpdateFile) {
    UserSchema userUpdate = userUpdateFile;
    if (_formKey.currentState!.validate()) {
      /// on assigne tous les champ dans la variable userUpdate si elle sont vide on y laisse la valeur de départ
      if (email != '') {
        userUpdate.email = email;
      }
      if (firstName != '') {
        userUpdate.firstName = firstName;
      }
      if (lastName != '') {
        userUpdate.lastName = lastName;
      }
      if (pseudo != '') {
        userUpdate.pseudo = pseudo;
      }

      /// requet pour le update du user
      ref.watch(userState).updateUser(userUpdate.id!, userUpdate);

      /// affiche le message de succes
      NotifMessage(
        text: UserConstant.updateUserMessageSucces,
        error: false,
      ).notification(context);

      /// ferme le volet update user
      widget.closedUpdated!();
    } else {
      /// affiche le message d'erreur
      NotifMessage(
        text: UserConstant.updateUserMessageError,
        error: true,
      ).notification(context);
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
                decoration: const InputDecoration(
                  labelText: 'Nom :',
                ),
                style: const TextStyle(
                  fontSize: 22,
                ),
                initialValue: user!.firstName!,
                validator: (value) => Validator.validatorInputTextBasic(
                  textError: Validator.inputFirstName,
                  value: value,
                ),
                onChanged: (value) => firstName = value,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Prénom :',
                ),
                style: const TextStyle(
                  fontSize: 22,
                ),
                initialValue: user.lastName!,
                validator: (value) => Validator.validatorInputTextBasic(
                  textError: Validator.inputFirstName,
                  value: value,
                ),
                onChanged: (value) => lastName = value,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pseudo :',
                ),
                style: const TextStyle(
                  fontSize: 22,
                ),
                initialValue: user.pseudo!,
                validator: (value) => Validator.validatorInputTextBasic(
                  textError: Validator.inputFirstName,
                  value: value,
                ),
                onChanged: (value) => pseudo = value,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email : ',
                ),
                initialValue: user.email,
                style: const TextStyle(
                  fontSize: 22,
                ),
                validator: (value) => Validator.validateEmail(
                  textError: Validator.inputConnexionEmail,
                  value: value,
                ),
                onChanged: (value) => email = value,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40, top: 20),
              child: ElevatedButton(
                onPressed: () => {
                  /// on met le changement de donnée dans une variable
                  userUpdateData = user,
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
