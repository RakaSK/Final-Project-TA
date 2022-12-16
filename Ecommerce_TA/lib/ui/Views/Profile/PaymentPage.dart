// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymentPage extends StatelessWidget {
//   final String title;
//   PaymentPage({Key? key, required this.title}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: new WebView(
//         initialUrl: "https://app.midtrans.com/payment-links/1658937236518",
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';

// // import 'package:midtrans_sdk/midtrans_sdk.dart';
// // import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   // await DotEnv.load();
// //   runApp(PaymentPage());
// // }

// // class PaymentPage extends StatefulWidget {
// //   @override
// //   _MyAppState createState() => _MyAppState();
// // }

// // class _MyAppState extends State<PaymentPage> {
// //   MidtransSDK? _midtrans;

// //   @override
// //   void initState() {
// //     super.initState();
// //     initSDK();
// //   }

// //   void initSDK() async {
// //     _midtrans = await MidtransSDK.init(
// //       config: MidtransConfig(
// //         clientKey: "Mid-client-j4TXxl3oUOAupw85",
// //         merchantBaseUrl: "https://app.midtrans.com/payment-links/1658937236518",
// //         colorTheme: ColorTheme(
// //           colorPrimary: Theme.of(context).accentColor,
// //           colorPrimaryDark: Theme.of(context).accentColor,
// //           colorSecondary: Theme.of(context).accentColor,
// //         ),
// //       ),
// //     );
// //     _midtrans?.setUIKitCustomSetting(
// //       skipCustomerDetailsPages: true,
// //     );
// //     _midtrans!.setTransactionFinishedCallback((result) {
// //       print(result.toJson());
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _midtrans?.removeTransactionFinishedCallback();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Plugin example app'),
// //         ),
// //         body: Center(
// //           child: ElevatedButton(
// //             child: Text("Pay Now"),
// //             onPressed: () async {
// //               _midtrans?.startPaymentUiFlow(
// //                   // token: DotEnv.env['SNAP_TOKEN'],
// //                   );
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
