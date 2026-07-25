class CategoriesResponseEntity {
  int id;
  String name;
  String slug;
  String image;
  String creationAt;
  String updatedAt;

  CategoriesResponseEntity({
    this.id = 0,
    this.name = '',
    this.slug = '',
    this.image = '',
    this.creationAt = '',
    this.updatedAt = '',
  });
}
