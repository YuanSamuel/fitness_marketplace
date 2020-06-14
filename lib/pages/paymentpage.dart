import 'package:fitnessmarketplace/pages/show_video_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';


 class PaymentPage extends StatefulWidget{

   _PaymentPageState createState() => _PaymentPageState();

 }

 class _PaymentPageState extends State<PaymentPage>{

   void _pay(){
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://www.paymentsjournal.com/wp-content/uploads/2017/05/Fotolia_90732811_Subscription_Monthly_M.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Please Proceed to make your payment'
            )
          ],
        ),
      ),
          floatingActionButton: FloatingActionButton(
          onPressed: _pay,
          tooltip: 'Enter Card Number',
          child: Icon(Icons.payment),
      ),
    );
  }




 }

