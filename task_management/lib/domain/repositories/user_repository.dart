import 'package:dartz/dartz.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<String, List<User>>> fetchUsers();
  Future<Either<String, User>> getUserById(String userId);
  Future<Either<String, User>> getCurrentUser();
}
