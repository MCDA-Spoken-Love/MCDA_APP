import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:mcda_app/common/blocs/biometric_lock/biometric_lock_event.dart';
import 'package:mcda_app/common/blocs/biometric_lock/biometric_lock_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final LocalAuthentication auth = LocalAuthentication();
Logger logger = Logger(
  printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
);

class BiometricLockBloc extends Bloc<BiometricLockEvent, BiometricLockState> {
  BiometricLockBloc() : super(BiometricLockInitial()) {
    on<BiometricLockCallback>((event, emit) async {
      final res = await _getPrefs();
      final isSupported = await auth.isDeviceSupported();
      if (isSupported && res['biometric_lock'] == true) {
        emit(BioLockUnauthenticated());
        final authenticated = await _authenticate();
        if (authenticated) {
          emit(BioLockAuthenticated());
        }
      } else {
        emit(BioLockAuthenticated());
      }
    });
  }

  Future<Map<String, dynamic>> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {"biometric_lock": prefs.getBool('biometric_lock') ?? false};
  }

  Future<bool> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to access the app\'s functionalities',
        options: const AuthenticationOptions(stickyAuth: true),
      );
      return authenticated;
    } on PlatformException catch (e) {
      logger.e(e);
      return false;
    }
  }
}
