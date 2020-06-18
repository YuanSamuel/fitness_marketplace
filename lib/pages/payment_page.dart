import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(
        title: Text('Proceed to Payment',
        style: TextStyle(
          fontStyle: FontStyle.italic
         ),
        )
      ),
      body : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://www.debt.com/wp-content/uploads/2014/05/Credit-Card-Visa-Master-Card-Background.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter
          )
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed:_pay,
        tooltip: 'Enter Card Number',
        child: Icon(Icons.payment),
      ),

    );
  }




 }

