/// Represents the role of the user
enum UserRole { VOLUNTEER, ADMIN, REGION_ADMIN, SUPER_ADMIN }

extension UserRoleExtensions on UserRole {
  String value() {
    return this.toString().split('.').last;
  }

  String valueUkrainian() {
    switch (this) {
      case UserRole.VOLUNTEER:
        return 'Волонтер';
      case UserRole.ADMIN:
        return 'Адміністратор Молодіжного Центру';
      case UserRole.REGION_ADMIN:
        return 'Адміністратор Обласного Молодіжного Центру';
      case UserRole.SUPER_ADMIN:
        return 'Суперадміністратор';
    }
  }
}
