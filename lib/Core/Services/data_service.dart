abstract class DatabaseService {
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? docuementId});
  Future<Map<String, dynamic>> getData(
      {required String path, required String docuementId});

  Future<bool> checkIfDatatExists(
      {required String path, required String docuementId});
}
