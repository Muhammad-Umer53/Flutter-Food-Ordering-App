import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/custom_models/cart_item.dart';
import 'package:food_ordering_app/screens/calculator_screen.dart';
import 'package:food_ordering_app/screens/full_menu_screen.dart';
import 'package:food_ordering_app/widgets/custom_widgets/responsive_text.dart';

import '../widgets/custom_widgets/custom_card_widget.dart';
import '../widgets/custom_widgets/custom_elevated_button.dart';
import 'delivery_address_screen.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int calculateTotalPrice(List<CartItem> cartItems) {
    int totalPrice = 0;

    for (CartItem cartItem in cartItems) {
      int totalEachFoodPrice =
          (cartItem.food!.foodQuantity) * (cartItem.food!.foodPrice);
      totalPrice += totalEachFoodPrice;
    }

    return totalPrice;
  }

  @override
  void setState(VoidCallback fn) {
    calculateTotalPrice(cartItems);

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Cart"),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 22, color: Colors.black),
      ),
      body: Column(
        children: [
          // displaying the food which are added to cart
          cartItems.isEmpty
              ? Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: MyResponsiveText(
                        'Your cart is empty!',
                        scaleFactor: 0.017,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  flex: 2,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      var foodItemTotalPrice = 0;
                      foodItemTotalPrice = ((cartItems[index].food!.foodPrice) *
                          (cartItems[index].food!.foodQuantity));

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyCard(
                          elevation: 6,
                          containerHeight: 80,
                          contentWidget: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                cartItems[index].food!.foodImageURL,
                                fit: BoxFit.contain,
                                height: 70,
                                width: 70,
                              ),
                              Text(
                                cartItems[index].food!.foodName,
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                "Rs $foodItemTotalPrice",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

          // displaying total prices & checkout button
          Expanded(
              child: MyCard(
            elevation: 20,
            borderCurve: 22,
            containerHeight: MediaQuery.sizeOf(context).width * 1,
            contentWidget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Total Price',
                      textScaleFactor: 1,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rs. ${calculateTotalPrice(cartItems)}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                          textScaleFactor: 1,
                        ),
                        const Text(
                          "(Delivery fees is not included)",
                          textScaleFactor: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Not sure on total price? ',
                      textScaleFactor: 1,
                      maxLines: 1,
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CalculatorScreen(),
                              ));
                        },
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 17, color: Colors.red.shade800),
                        ))
                  ],
                ),
                Flexible(
                  child: MyElevatedButton(
                    elevation: 0,
                    buttonColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    textCoLor: Colors.red.shade800,
                    buttonText: "Add items",
                    buttonPress: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FullMenuScreen(),
                          ));
                    },
                  ),
                ),
                Flexible(
                  child: MyElevatedButton(
                    surfaceTintColor: Colors.red,
                    buttonText: "CheckOut",
                    buttonPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DeliveryAddressScreen(),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
