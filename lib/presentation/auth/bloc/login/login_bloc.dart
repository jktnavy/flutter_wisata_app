import 'package:bloc/bloc.dart';
import 'package:flutter_wisata_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_wisata_app/data/models/request/login_request_model.dart';
import 'package:flutter_wisata_app/data/models/response/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDataSource authRemoteDataSource;
  LoginBloc(
    this.authRemoteDataSource,
  ) : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(_Loading());
      final dataRequest = LoginRequestModel(
        email: event.email,
        password: event.password,
      );

      final response = await authRemoteDataSource.login(dataRequest);

      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data)),
      );
    });
  }
}
