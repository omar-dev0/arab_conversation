sealed class PaymentStatus{}

class InitStatePayment extends PaymentStatus{}

class ErrorState extends PaymentStatus{
  String error;
  ErrorState(this.error);
}
class Success extends PaymentStatus {
}