import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local_storage.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<String, List<User>>> fetchUsers() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final users = LocalStorage.usersBox.values.toList();
      return Right(users);
    } catch (e) {
      return Left('Failed to fetch users: $e');
    }
  }

  @override
  Future<Either<String, User>> getUserById(String userId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 400));
      
      final user = LocalStorage.usersBox.get(userId);
      if (user == null) {
        return Left('User not found');
      }
      
      return Right(user);
    } catch (e) {
      return Left('Failed to get user: $e');
    }
  }

  @override
  Future<Either<String, User>> getCurrentUser() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      
      // For demo purposes, return the first admin user
      final adminUsers = LocalStorage.usersBox.values
          .where((user) => user.role == UserRole.admin)
          .toList();
      
      if (adminUsers.isEmpty) {
        return Left('No admin user found');
      }
      
      return Right(adminUsers.first);
    } catch (e) {
      return Left('Failed to get current user: $e');
    }
  }
}
