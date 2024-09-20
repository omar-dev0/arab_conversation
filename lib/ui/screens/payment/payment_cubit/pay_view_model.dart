import 'dart:async';

import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/data/repository/auth_repo.dart';
import 'package:arab_conversation/data/repository/course_repo.dart';
import 'package:arab_conversation/ui/screens/payment/payment_cubit/payment_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentViewModel extends Cubit<PaymentStatus>{
  final CourseRepo courseRepo;
  final AuthRepo authRepo;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late final List<Course> available = courseRepo.availableCourse;
  List<ProductDetails> products = [];
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  final Set<String> pIds = {};
  late final ProductDetailsResponse response;
  @factoryMethod
  PaymentViewModel(this.courseRepo , this.authRepo):super(InitStatePayment());

  void getIDS() async {
    for (Course course in courseRepo.availableCourse) {
      pIds.add(course.id ?? '');
    }
    response = await _inAppPurchase.queryProductDetails(pIds);
    if(response.notFoundIDs.isNotEmpty)
      {
        emit(ErrorState('Not found product'));
      }
    else
      {
        products = response.productDetails;
      }
  }

  void startStream(){
    _subscription = _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    });
    _getProducts();
  }

  void _getProducts() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      emit(ErrorState('Some thing went wrong please try again'));
    }
    getIDS();
      return;
    }


  Future<void> buyProduct(ProductDetails productDetails)async {

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }


  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Show pending UI.
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          emit(ErrorState('some thing wrong in payment'));
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          _verifyPurchase(purchaseDetails);
          emit(Success());
        }
        if (purchaseDetails.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }
  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    for(Course course in available)
      {
        if (course.id?.toLowerCase() == purchaseDetails.productID.toLowerCase())
          {
            await courseRepo.addToPayCourse(course, authRepo.get().id ?? "");
            courseRepo.userPaidCourses.add(course);
            break;
          }
      }
  }
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

}