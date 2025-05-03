// import 'dart:async';

// import 'package:flutter/material.dart';

// class _PackagesPageState extends State<PackagesPage> {
//   Duration remainingTime = Duration.zero;
//   Timer? _timer;
//   late final InAppPurchase _inAppPurchase;
//   late final StreamSubscription _streamSubscription;
//   late final List<ProductDetails> _in_app_purchase_subscriptions = [];
//   final List<PurchaseDetails> _purchases = [];
//   late final StreamSubscription<List<PurchaseDetails>> _subscriptions;
//   late Set<String> identifiers = {
//     "net.dreamfitness.plan_1",
//     "net.dreamfitness.plan_2",
//   };

//   @override
//   void initState() {
//     log("initstate is called");
//     super.initState();
//     _inAppPurchase = InAppPurchase.instance;
//     final Stream<List<PurchaseDetails>> purchaseUpdated =
//         _inAppPurchase.purchaseStream;
//     _subscriptions = purchaseUpdated.listen((purchaseDetailsList) {
//       setState(() {
//         _purchases.addAll(purchaseDetailsList);
//       });
//     }, onDone: () {
//       _subscriptions.cancel();
//     }, onError: (e) {
//       _subscriptions.cancel();
//     });
//     _fetchProducts();
//     _listenToPurchaseUpdates();
//   }

//   Future<void> _purchaseSubscription(ProductDetails product) async {
//     final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
//     await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
//   }

//   void _listenToPurchaseUpdates() {
//     _inAppPurchase.purchaseStream.listen(
//       (List<PurchaseDetails> purchaseDetailsList) {
//         for (var purchaseDetails in purchaseDetailsList) {
//           if (purchaseDetails.status == PurchaseStatus.purchased) {
//             print("Purchase successful: ${purchaseDetails.productID}");
//           } else if (purchaseDetails.status == PurchaseStatus.error) {
//             print("Purchase error: ${purchaseDetails.error}");
//           }
//         }
//       },
//     );
//   }

//   void _fetchProducts() async {
//     log("_fetchProducts is called");

//     final bool available = await _inAppPurchase.isAvailable();
//     log("Store availability: $available");

//     if (!available) {
//       print("❌ StoreKit is NOT available");
//       return;
//     }

//     log("Querying products...");
//     final productDetailsResponse =
//         await _inAppPurchase.queryProductDetails(identifiers);

//     if (productDetailsResponse.error != null) {
//       log("❌ Error fetching products: ${productDetailsResponse.error}");
//       return;
//     }

//     if (productDetailsResponse.productDetails.isEmpty) {
//       log("⚠ No products found. Check product IDs and store setup.");
//       return;
//     }

//     _in_app_purchase_subscriptions
//         .addAll(productDetailsResponse.productDetails);
//     log("✅ Fetched ${_in_app_purchase_subscriptions.length} subscriptions");
//   }

//   // void _fetchProducts() async {
//   //   log("_fetchProducts is called");
//   //   final bool available = await _inAppPurchase.isAvailable();
//   //   if (!available) {
//   //     print("❌ StoreKit is NOT available");
//   //     return;
//   //   }
//   //   final productDetailsResponse =
//   //       await _inAppPurchase.queryProductDetails(identifiers);
//   //   if (productDetailsResponse.error != null) {
//   //     log("Error fetching products: ${productDetailsResponse.error}");
//   //   } else if (productDetailsResponse.productDetails.isEmpty) {
//   //     log("No products found. Check product IDs and store setup.");
//   //   } else {
//   //     _in_app_purchase_subscriptions
//   //         .addAll(productDetailsResponse.productDetails);
//   //     log("Fetched ${_in_app_purchase_subscriptions.length} subscriptions");
//   //   }
//   // }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   void startCountdownTimer(int timestamp, String humanReadable) {
//     DateTime discountEndDate =
//         DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

//     if (discountEndDate.isAfter(DateTime.now())) {
//       remainingTime = discountEndDate.difference(DateTime.now());

//       if (humanReadable.contains("ساعة")) {
//         _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//           setState(() {
//             remainingTime = discountEndDate.difference(DateTime.now());

//             if (remainingTime.isNegative) {
//               remainingTime = Duration.zero;
//               _timer?.cancel();
//             }
//           });
//         });
//       } else {
//         _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//           setState(() {
//             remainingTime = discountEndDate.difference(DateTime.now());

//             if (remainingTime.isNegative) {
//               remainingTime = Duration.zero;
//               _timer?.cancel();
//             }
//           });
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final int days = remainingTime.inDays;
//     final int hours = remainingTime.inHours.remainder(24);
//     final int minutes = remainingTime.inMinutes.remainder(60);
//     final int seconds = remainingTime.inSeconds.remainder(60);

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: Text('packages'.tr()),
//       ),
//       body: ChangeNotifierProvider<PackagesViewModel>(
//         create: (context) => PackagesViewModel()..fetchPackages(),
//         child: Consumer<PackagesViewModel>(
//           builder: (context, viewModel, child) {
//             if (viewModel.isLoading) {
//               return Center(child: CustomLoader());
//             } else if (viewModel.errorMessage != null) {
//               return Center(child: Text(viewModel.errorMessage!));
//             } else if (viewModel.plans == null ||
//                 viewModel.plans!.data.isEmpty) {
//               return Center(child: Text('No packages available'));
//             } else {
//               return _buildPackagesList(
//                   viewModel.plans!.data, days, hours, minutes, seconds);
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildPackagesList(
//       List<Datum> packages, int days, int hours, int minutes, int seconds) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//             child: Text('الباقات',
//                 style: TextStyle(color: foodAuthorityColors, fontSize: 18)),
//           ),
//           ListView.separated(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: packages.length,
//             separatorBuilder: (context, index) => SizedBox(height: 12.0),
//             itemBuilder: (context, index) {
//               final package = packages[index];
//               final discountEndDateTimestamp =
//                   package.attributes.discountEndDate?.timestamp;

//               final discountEndDateDayIt = package
//                   .attributes.discountEndDate?.dateString; // Changed to string

//               if (discountEndDateTimestamp != null) {
//                 startCountdownTimer(
//                     discountEndDateTimestamp,
//                     package.attributes.discountEndDate?.human ??
//                         ""); // Pass human string
//               }

//               return Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: whiteColor,
//                     borderRadius: BorderRadius.circular(22),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 10),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment:
//                               package.attributes.discountPercent != null
//                                   ? MainAxisAlignment.spaceBetween
//                                   : MainAxisAlignment.center,
//                           children: [
//                             Text('${package.attributes.name}',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.bold)),
//                             if (package.attributes.discountPercent != null) ...[
//                               const Spacer(),
//                               Text(
//                                 '${package.attributes.discountPercent}% discount',
//                                 style: TextStyle(
//                                     fontSize: 17, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         if (discountEndDateTimestamp != null) ...[
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Container(
//                               width: 150,
//                               height: 75,
//                               decoration: BoxDecoration(
//                                 border:
//                                     Border.all(color: Colors.grey, width: 1),
//                               ),
//                               child: Column(
//                                 children: [
//                                   const Text(
//                                     "باقى على الخصم",
//                                     style: TextStyle(fontSize: 14),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       if (days > 0) ...[
//                                         Flexible(
//                                             child: buildTimeColumn(
//                                                 '$days', "يوم")),
//                                         SizedBox(width: 4),
//                                       ],
//                                       Text(":"),
//                                       Flexible(
//                                           child: buildTimeColumn(
//                                               '$hours', "ساعة")),
//                                       Text(":"),
//                                       SizedBox(width: 4),
//                                       Flexible(
//                                           child: buildTimeColumn(
//                                               '$minutes', "دقيقة")),
//                                       Text(":"),
//                                       SizedBox(width: 4),
//                                       Flexible(
//                                           child: buildTimeColumn(
//                                               '$seconds', "ثانية")),
//                                     ],
//                                   ),
//                                   SizedBox(height: 8),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                         SizedBox(height: 10.0),
//                         Text('${package.attributes.duration} يوم',
//                             style: TextStyle(fontSize: 18)),
//                         const SizedBox(height: 10.0),
//                         Row(
//                           children: [
//                             Text(package.attributes.price.formatted,
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.bold)),
//                             const SizedBox(width: 10.0),
//                             if (package.attributes.discountPrice != null)
//                               Text(
//                                 package.attributes.discountPrice!.formatted,
//                                 style: TextStyle(
//                                     fontSize: 17,
//                                     color: textPackagesSaleColor,
//                                     decoration: TextDecoration.lineThrough),
//                               ),
//                           ],
//                         ),
//                         const SizedBox(height: 20.0),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: package.attributes.features != null &&
//                                   package.attributes.features.isNotEmpty
//                               ? package.attributes.features.map((feature) {
//                                   return Column(
//                                     children: [
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SvgPicture.asset(
//                                               "assets/icons/check.svg",
//                                               width: 20,
//                                               height: 25),
//                                           const SizedBox(width: 8.0),
//                                           Expanded(
//                                             child: Text(feature,
//                                                 style: TextStyle(
//                                                     fontSize: 17,
//                                                     color:
//                                                         textPackagesSaleColor)),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8.0),
//                                     ],
//                                   );
//                                 }).toList()
//                               : [Text("")],
//                         ),
//                         const SizedBox(height: 10.0),
//                         CustomButtons(
//                           width: 110,
//                           height: 40,
//                           borderRadius: 8,
//                           text: 'إختيار الباقة',
//                           onTap: () {
//                             try {
//                               _purchaseSubscription(
//                                   _in_app_purchase_subscriptions[0]);
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                     "You have subscribed sucessfully",
//                                   ),
//                                 ),
//                               );
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) => HomePage()));
//                             }
//                             //  ProductDetailsResponse response = await InAppPurchase.instance
//                             // .queryProductDetails({offerProvider.offerDetails!.appleId});
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildTimeColumn(String timeValue, String label) {
//     return Column(
//       children: [
//         Text(
//           timeValue,
//           style: TextStyle(
//               fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           label,
//           style: TextStyle(fontSize: 14),
//         ),
//       ],
//     );
//   }
// }
