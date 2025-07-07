import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_management/features/batch/domain/use_case/delete_batch_usecase.dart';

import 'repositoyr.mock.dart';

void main() {
  late MockBatchRepository mockBatchRepository;
  late DeleteBatchUsecase usecase;
  setUp(() {
    mockBatchRepository = MockBatchRepository();
    usecase = DeleteBatchUsecase(batchRepository: mockBatchRepository);
  });
  final batchId = 'batch123';

  test('delete batch usecase ...', () async {
    // arrange
    when(() => mockBatchRepository.deleteBatch(batchId))
        .thenAnswer((_) async => const Right(null));

    // act
    final result = await usecase(DeleteBatchParams(batchId: batchId));

    // assert
    expect(result, const Right(null));
    verify(() => mockBatchRepository.deleteBatch(batchId)).called(1);
    verifyNoMoreInteractions(mockBatchRepository);
  });
}