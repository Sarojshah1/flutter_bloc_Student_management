import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/use_case/get_all_batch_usecase.dart';

import 'repositoyr.mock.dart';

void main() {
  late MockBatchRepository mockBatchRepository;
  late GetAllBatchUsecase usecase;
  setUp(() {
    mockBatchRepository = MockBatchRepository();
    usecase = GetAllBatchUsecase(batchRepository: mockBatchRepository);
  });
  final batch1=BatchEntity(batchId: '1', batchName: 'Batch 1');
  final batch2=BatchEntity(batchId: '2', batchName: 'Batch2');
  final tbatches = [batch1, batch2];
  test('get all batch usecase ...', () async {
    when(() => mockBatchRepository.getBatches())
        .thenAnswer((_) async => Right(tbatches));
         final result = await usecase();
    // assert
    expect(result, Right(tbatches));
    verify(() => mockBatchRepository.getBatches()).called(1);
    verifyNoMoreInteractions(mockBatchRepository);
  });



}
