import 'package:fitnessmarketplace/pages/show_video_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';


 class PaymentPage extends StatefulWidget{

   _PaymentPageState createState() => _PaymentPageState();

 }

 class _PaymentPageState extends State<PaymentPage>{

   void_pay(){
     InAppPayments.setSquareApplicationId('***REMOVED***');
     InAppPayments.startCardEntryFlow(
       onCardNonceRequestSuccess: _onCardNonceRequestSuccess,
       onCardEntryCancel: _onCardEntryCancel,
     );
   }

   void _onCardEntryCancel(){


   }


   void _onCardNonceRequestSuccess(CardDetails result ){
     print('result.nonce');

     InAppPayments.completeCardEntry(
       onCardEntryComplete: _cardEntryComplete,
     );

   }
   void _cardEntryComplete(){

   }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }




 }

