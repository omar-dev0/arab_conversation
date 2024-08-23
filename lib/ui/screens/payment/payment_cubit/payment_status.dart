sealed class PaymentStatus{}

class InitStatePayment extends PaymentStatus{}

class ErrorState extends PaymentStatus{
  final String error;
  ErrorState(this.error);
}
class Success extends PaymentStatus {
}