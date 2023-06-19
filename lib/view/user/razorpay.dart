import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentScreen extends StatefulWidget {
  String amount;
  String email;
  String booking_id;

  RazorpayPaymentScreen(
      {required this.amount, required this.booking_id, required this.email});

  @override
  _RazorpayPaymentScreenState createState() => _RazorpayPaymentScreenState();
}

class _RazorpayPaymentScreenState extends State<RazorpayPaymentScreen> {
  Razorpay _razorpay = Razorpay();
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Handle payment success
    print('Payment successful. Payment ID: ${response.paymentId}');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("payment Done")));
    FirebaseFirestore.instance
        .collection('appoinments')
        .doc(widget.booking_id)
        .update({"status": "booked", 'payment_id': response.paymentId}).then(
            (value) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }, onError: (_, __) {});
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print(
        'Payment failed. Code: ${response.code}, Message: ${response.message}');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("payment error")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print('External wallet selected: ${response.walletName}');
  }

  void _startPayment() {
    double amount = double.tryParse(widget.amount) ?? 0.0;
    int amountInPaise = (amount * 100).toInt();

    var options = {
      'key': 'rzp_test_dmyA27KJtmtkvu',
      'amount': amountInPaise,
      'description': 'Payment for doctor consultation',
      'prefill': {'email': widget.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              "Rs: " + widget.amount,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _startPayment();
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
