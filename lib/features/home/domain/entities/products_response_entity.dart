class ProductsResponseEntity {
  int id;
  String title;
  String slug;
  int price;
  String description;
  CategoryEntity category;
  List<String> images;
  String creationAt;
  String updatedAt;

  ProductsResponseEntity({
    this.id = 0,
    this.title = '',
    this.slug = '',
    this.price = 0,
    this.description = '',
    this.category = const CategoryEntity(),
    this.images = const [],
    this.creationAt = '',
    this.updatedAt = '',
  });
}

class CategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String creationAt;
  final String updatedAt;

  const CategoryEntity({
    this.id = 0,
    this.name = '',
    this.slug = '',
    this.image = '',
    this.creationAt = '',
    this.updatedAt = '',
  });
}
