import '../../core/network/api_client.dart';
import '../../models/category_model.dart';

class CategoryRepository {
  final ApiClient _apiClient;

  CategoryRepository(this._apiClient);

  Future<List<CategoryModel>> getCategories(String type) async {
    final response = await _apiClient.get(
      'categories',
      queryParameters: {'type': type},
    );

    if (response.data is List) {
      return (response.data as List)
          .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
