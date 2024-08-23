import 'package:arab_conversation/di/di.dart';
import 'package:arab_conversation/ui/screens/payment/payment_cubit/pay_view_model.dart';
import 'package:arab_conversation/ui/screens/payment/payment_cubit/payment_status.dart';
import 'package:arab_conversation/ui/shared_widgets/course_item_widget.dart';
import 'package:arab_conversation/ui/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../data/model/course.dart';

class PaymentScreen extends StatelessWidget {
  static const String route = "payment";
  final Course course;
    PaymentScreen({super.key ,required this.course});
   final PaymentViewModel payment = getIt.get<PaymentViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>payment..startStream(),
      child: BlocConsumer<PaymentViewModel , PaymentStatus>(
        listener: (context , status){
          if(status is Success)
            {
              Navigator.pop(context);
            }
        },
        builder: (context , status)=> Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/app_screen.png'),
                  fit: BoxFit.cover
              )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: const Color(0xFFECEDED),
              title: Text(
                'Payment' ,
                style:Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 20.sp) ,),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CourseItemWidget(courseItem: null , courseName:course.name ?? "" , index: 1 , isPayment: true,),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          '${course.price} \$',
                          style: Theme.of(context).textTheme.labelMedium,
                        )
                      ],
                    ),
                  ),
                  CustomButton(text: 'Payment', onPress: () async{
                    for(ProductDetails product in payment.products)
                      {
                        if(product.title.toLowerCase().contains(course.name!.toLowerCase()))
                          {
                             payment.buyProduct(product);
                            break;
                          }
                      }
                  }),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}
