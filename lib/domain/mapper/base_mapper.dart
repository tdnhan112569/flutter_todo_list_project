abstract class Mapper<I, O> {
  O mapToDataProvider(I input);
  I mapToViewModel(O input);
}
