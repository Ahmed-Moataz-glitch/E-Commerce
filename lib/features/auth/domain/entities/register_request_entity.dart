class RegisterRequestEntity {
  String name;
  String email;
  String password;
  String avatar;

  RegisterRequestEntity({
    this.name = '',
    this.email = '',
    this.password = '',
    this.avatar = 'https://api.lorem.space/image/face?w=640&h=480',
  });
}
