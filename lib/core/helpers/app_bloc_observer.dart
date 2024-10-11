import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('Block - $bloc  - ${bloc.runtimeType} Created! State ${bloc.state}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('Block - $bloc  Changed! State ${bloc.state} Change - ${change}');
  }
}
