import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/use_case/create_batch_usecase.dart';

import 'repositoyr.mock.dart';

void main() {
  late MockBatchRepository mockBatchRepository;
  late CreateBatchUsecase usecase;
  setUp(() {
    mockBatchRepository = MockBatchRepository();
    usecase=CreateBatchUsecase(batchRepository: mockBatchRepository);
    registerFallbackValue(BatchEntity.empty());
  });
  final params=CreateBatchParams.initial();
  test('should call the [batchRepo.createBatch]', () async {
    // arrange
    when(() => mockBatchRepository.addBatch(any()))
        .thenAnswer((_) async =>  Right(null));

 
    final result = await usecase(params);

    // assert
    expect(result, Right(null));
    verify(() => mockBatchRepository.addBatch(any())).called(1);

    verifyNoMoreInteractions(mockBatchRepository);
  });
}