import 'package:volunteer/models/user_role.dart';

/// Represents filter selection on the users list
class UserFilters {
  /// The role of the user from [UserRole]
  int userRole;

  /// True if show not approved users
  bool notApproved;

  UserFilters({userRole, notApproved})
      : userRole = userRole ?? -1,
        notApproved = notApproved ?? false;
}
