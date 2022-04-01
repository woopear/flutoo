import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutoo/config/routes/routes.dart';
import 'package:flutoo/models/auth/auth_state.dart';
import 'package:flutoo/models/profil/widgets/profil_user_card/profil_user_card.dart';
import 'package:flutoo/models/profil/widgets/profil_user_card/profil_user_update/profil_user_update.dart';
import 'package:flutoo/models/upload/upload.dart';
import 'package:flutoo/models/user/user_shema.dart';
import 'package:flutoo/models/user/user_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilUser extends ConsumerStatefulWidget {
  const ProfilUser({Key? key}) : super(key: key);

  @override
  _ProfilUserState createState() => _ProfilUserState();
}

class _ProfilUserState extends ConsumerState<ProfilUser> {
  bool seeUpdate = false;
  bool seeUpdateAvatar = false;
  dynamic file;
  String? extention;

  /// affiche/cache volet update user
  void openCloseUpdated() {
    setState(() {
      seeUpdate = !seeUpdate;
    });
  }

  /// affiche/cache volet update user
  void openCloseUpdatedAvatar() {
    setState(() {
      seeUpdateAvatar = !seeUpdateAvatar;
    });
  }

  /// delete le user
  void deleteUser(BuildContext context, String id) {
    ref.watch(userState).delete(id);
    ref.watch(authState).deleteAuth();
    Navigator.pushNamed(context, Routes().home);
  }

  /// selection du fichier à télécharger
  Future<void> selectAvatar() async {
    /// si web sinon le reste
    if (kIsWeb) {
      /// creation conteneur pour fichier
      final picker = await FilePicker.platform.pickFiles();
      if (picker == null) return;

      /// on recupere le path
      setState(() {
        file = picker.files.first.bytes;
        extention = picker.files.first.extension;
      });
    } else {
      /// creation conteneur pour fichier
      final picker = await FilePicker.platform.pickFiles(allowMultiple: false);
      if (picker == null) return;

      /// on recupere le fichier
      setState(() {
        file = File(picker.files.single.path!);
      });
    }
  }

  /// telecharge l'image dans firestorage
  Future<void> uploadAvatar(UserSchema user) async {
    String? url;

    /// upload + recupere url
    if (file != null) {
      /// upload + recuperation de l'url
      if (kIsWeb) {
        url = await ref
            .watch(uploadFileChange)
            .uploadAvatar(file, user.uid!, extension: extention!);
      } else {
        url = await ref.watch(uploadFileChange).uploadAvatar(file, user.uid!);
      }

      /// on affecte l'url à avatar du user
      user.avatar = url;

      /// modifier user pour ajouter url à avatar
      await ref.watch(userState).updateUser(user.id!, user);

      /// reset et ferme le volet update image
      file = null;
      openCloseUpdatedAvatar();
    }
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere le user connecté
    final user = ref.watch(userCurrent);
    final avatar = user!.avatar;

    /// message de selection de fichier
    final fileName =
        file != null ? '1 fichier prêt à etre télécharger' : 'Aucun fichier';

    return Center(
      child: Column(
        children: [
          /// title de la page
          Container(
            margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: const Text(
              "Profil de l'utilisateur",
              style: TextStyle(fontSize: 28),
            ),
          ),

          /// cadre image user
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !seeUpdateAvatar

                  /// image
                  ? Align(
                      child: Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      child: avatar != "" || avatar != null
                          ? Image.network(
                              avatar!.toString(),
                              width: 80.0,
                              height: 80.0,
                            )
                          : const Icon(Icons.person, size: 100.0),
                    ))

                  /// btn selected image
                  : Align(
                      child: Column(
                        children: [
                          /// btn selected image
                          ElevatedButton(
                            onPressed: () async {
                              await selectAvatar();
                            },
                            child: const Text(
                              'Selectionner votre image',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),

                          /// cadre text info upload / btn telecharger
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              children: [
                                /// text fichier selectionné
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20.0),
                                  child: Text(fileName),
                                ),

                                /// btn telecharger
                                ElevatedButton(
                                  onPressed: file != null
                                      ? () async {
                                          await uploadAvatar(user);
                                        }
                                      : null,
                                  child: const Text(
                                    'Télécharger',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

              /// btn open close update image user
              Container(
                margin: seeUpdateAvatar
                    ? const EdgeInsets.only(left: 20.0)
                    : EdgeInsets.zero,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  hoverColor: Colors.transparent,
                  alignment: Alignment.topLeft,
                  onPressed: () {
                    openCloseUpdatedAvatar();
                    setState(() {
                      file = null;
                    });
                  },
                  color: seeUpdateAvatar
                      ? Colors.red
                      : Theme.of(context).colorScheme.primary,
                  icon: seeUpdateAvatar
                      ? const Icon(
                          Icons.close,
                        )
                      : const Icon(
                          Icons.edit,
                        ),
                ),
              ),
            ],
          ),

          /// cadre info + update info
          Container(
            width: 500,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: Column(
              children: [
                /// groupe btn update user + close update user
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    seeUpdate

                        /// icon close
                        ? Container(
                            child: Align(
                              child: IconButton(
                                onPressed: () {
                                  openCloseUpdated();
                                },
                                color: Colors.red,
                                icon: const Icon(
                                  Icons.close,
                                ),
                              ),
                            ),
                          )

                        /// icon upate
                        : Container(
                            child: Align(
                              child: IconButton(
                                onPressed: () {
                                  openCloseUpdated();
                                },
                                color: Theme.of(context).colorScheme.primary,
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                seeUpdate
                    ? ProfilUserUpdate(
                        closedUpdated: () => openCloseUpdated(),
                      )
                    : const ProfilUserCard(),
                !seeUpdate
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 40, top: 20),
                        child: ElevatedButton(
                          onPressed: () => {deleteUser(context, user.id!)},
                          child: const Text(
                            'Effacer le compte',
                          ),
                        ),
                      )
                    : Container(),
                !seeUpdate
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 40, top: 20),
                        child: TextButton(
                          child: const Text('Changer le mot de passe'),
                          onPressed: () => {},
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
