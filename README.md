# Installation flutter + firebase et init un projet  

> faire les installations en fonction de votre systeme (windows, linux, macOs)
- installer node / npm  
https://nodejs.org/en/  

- installer git / github  
1. git : https://git-scm.com/book/fr/v2/D%C3%A9marrage-rapide-Installation-de-Git  

> github n'est pas obligatoir (facilité d'utilisation sur windows)  

2. github : https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/installing-and-authenticating-to-github-desktop/installing-github-desktop

- installer flutter sdk  
https://docs.flutter.dev/get-started/install  

- installer firebase CLI  
https://firebase.google.com/docs/cli  

- installer android studio (essenciellement pour l'émulateur mobile)  
https://developer.android.com/studio?hl=fr&gclsrc=aw.ds&gclid=CjwKCAiApfeQBhAUEiwA7K_UH8iKykG1AaA_ilxE6KsuxhHMkq5Hj_ZvFLRT6A-tow3JaV6fuJaFMhoCo1QQAvD_BwE  

- installer un emulateur mobile  
> aller dans la configuration SDV d'android studio  
> puis creer un nouveau device  

- installer le SDK android tool  
> aller dans configuration SDK d'android studio  
> puis télécharger le SDK android tool  

- executer la commande suivante  

```shell
$ flutter doctor
```  

> puis regler les problemes si il y en a listés  
> (il y a une erreur concernant visual studio (ce n'est pas  
> visual studio code), pour les applications  
> windows, cela va dépendre de l'utilisation  
> de l'application que vous créez,  
> mais pour le début cela n'est pas un probleme)  

- installation plugin vscode  

1. `dart` de dart code => extension dart =>  
parametre => ajouter " ui " dans la barre  
de recherche en haut puis cocher les deux  
premiere options  

2. `flutter` de dart code => extension flutter  

3. `flutter` tree de marcelo velasquez =>  
creation de composant rapide  

4. `firebase` de toba => pour syntaxe fichier firebase  

5. `firebase snippets` => snippet pour firebase  

6. `pubspec assist` de jeroen meijer  

- installation / creation du projet flutter  

```shell
$ flutter create nomduprojet
```  

- executer le projet (rechargement à chaud manuel)  

```shell
$ flutter run -d chrome (pour le web)
```  

> (choisissez un autre device que chrome  
> en fonction de la cible de développement,  
> mobile, desktop etc ...) ceci est la ligne  
> de commande d'execution, par concéquent  
> il faudra taper "r" ou "R" dans votre terminal  
> pour executer un reaload et ainsi afficher  
> vos modifications car le rechargement à chaud  
> ne foncionne pas avec cette commande.  
> CTRL + C pour arreter l'execution de l'application  

- executer le projet (rechargement à chaud auto)  

> pour utiliser le rechargement à chaud,  
> utilisez l'execution de l'applicationvia votre  
> éditeur de code, choisissez votre device puis executer.  
> Le rechargement à chaud s'effectue cette  
> fois à la sauvgarde de votre fichier modifié  
> arreter l'application via les commande de l'IDE  

### initialiser firebase pour le projet  

- installer le package firebase_core pour flutter  

```shell
$ flutter pub add firebase_core
```  
> ou utiliser une autre façon  
> (celle-ci n'est pas obligatoire ou unique)  

- activation de flutterfire en global  

```shell
$ dart pub global activate flutterfire_cli
```  

- init firebase pour le projet (executer à la racine)  

> il est préferable de configurer firebase  
> sur le site web avant de lancer cette instruction  
> configurer un projet web, android et IOS  

```shell
$ flutterfire configure
```  

ensuite suivre les instructions ATTENTION  
si vous choisissez IOS, il faudra au préalable  
recuperer l'id apple de l'application voir documentation  

https://firebase.flutter.dev/docs/manual-installation/ios  

car le flutterfire creer toute la configuration   
de firebase pour tout les types de projet mais pour IOS  
il demandera de renseigner cette id  

- init dans le projet (coté code)  
https://firebase.flutter.dev/docs/overview#initialization  

- il faudra installer chaque package d'outil de firebase  

> en fonction de votre utilisation  
> car flutterfire est divisé en plusieurs plugins

**l'application est prete et initialisé avec firebase**  

# flutoo  

> petit application de todo pour exemple de code  



