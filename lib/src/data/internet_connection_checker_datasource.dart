import 'dart:io';

abstract class IInternetConnectionCheckerDatasource {
  Future<bool> hasConnection();
}

class InternetConnectionCheckerDatasourceImpl
    implements IInternetConnectionCheckerDatasource {
  static final InternetConnectionCheckerDatasourceImpl _instance =
      InternetConnectionCheckerDatasourceImpl._internal();

  InternetConnectionCheckerDatasourceImpl._internal();

  factory InternetConnectionCheckerDatasourceImpl() {
    return _instance;
  }

  @override
  Future<bool> hasConnection() async {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 10))
        .onError((error, stackTrace) => []);

    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  }
}
