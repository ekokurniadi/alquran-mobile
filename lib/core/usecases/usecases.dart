import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:alquran_mobile/core/error/failures.dart";

abstract class UseCase<ReturnType, Params> {
	Future<Either<Failures,ReturnType>> call(Params params);
}

class NoParams extends Equatable {
	@override
	List<Object?> get props => [];
}
