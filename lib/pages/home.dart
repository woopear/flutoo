import 'package:flutoo/models/auth/widgets/auth_widget.dart';
import 'package:flutoo/pages/private/dashboard.dart';
import 'package:flutoo/utils/services/fireauth/fireauth_service.dart';
import 'package:flutoo/widget_shared/waiting_data/wating_data.dart';
import 'package:flutoo/widget_shared/waiting_error/waiting_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widget_shared/app_bar_flutoo/app_bar_flutoo.dart';
import 'package:flutter/material.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppBarFlutoo(),
        body: ref.watch(auth).when(
                loading: () => const WaitingData(),
                data: (data) =>
                    data != null ? const Dashboard() : const AuthWidget(),
                error: (error, stack) => const WaitingError(),
              ),
      ),
    );
  }
}
