import 'package:e_commerce_app/features/home/domain/entities/products_response_entity.dart';

class ProductsResponseDto {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  Category? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;

  ProductsResponseDto(
      {this.id,
      this.title,
      this.slug,
      this.price,
      this.description,
      this.category,
      this.images,
      this.creationAt,
      this.updatedAt});

  ProductsResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  ProductsResponseEntity toEntity() {
    return ProductsResponseEntity(
      id: id ?? 0,
      title: title ?? '',
      slug: slug ?? '',
      price: price ?? 0,
      description: description ?? '',
      category: category != null
          ? CategoryEntity(
              id: category!.id ?? 0,
              name: category!.name ?? '',
              slug: category!.slug ?? '',
              image: category!.image ?? '',
              creationAt: category!.creationAt ?? '',
              updatedAt: category!.updatedAt ?? '',
            )
          : const CategoryEntity(),
      images: images ?? [],
      creationAt: creationAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  Category(
      {this.id,
      this.name,
      this.slug,
      this.image,
      this.creationAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id ?? 0,
      name: name ?? '',
      slug: slug ?? '',
      image: image ?? '',
      creationAt: creationAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
