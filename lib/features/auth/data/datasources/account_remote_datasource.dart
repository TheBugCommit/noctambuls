import 'package:dio/dio.dart';

abstract class AccountRemoteDataSource {
  Future<void> deleteAccount();
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  const AccountRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<void> deleteAccount() async {
    await dio.delete<void>('/api/user/account');
  }
}
