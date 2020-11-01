import 'dart:async';
import 'package:lima_enam/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'authorization_bloc.dart';

class LoginBloc extends Validators {
  Repository repository = Repository();
  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (email, password) => true);

  Observable<bool> get loading => _loadingData.stream;

  void submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);
    login(validEmail, validPassword);
  }

  login(String email, String password) async {
    String token = await repository.login(email, password);
    _loadingData.sink.add(false);
    authBloc.openSession(token);
  }

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }
}

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String email, EventSink<String> sink) {
    //A standard email check regex
    Pattern pattern =
        r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(email))
      sink.add(email);
    else
      sink.addError('Enter a valid email');
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (String password, EventSink<String> sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('Password must be at least 8 characters long');
    }
  });
}
