import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class MyCheckout extends StatelessWidget {
  const MyCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Item Details"),
          getItems(context),
          const Divider(height: 4, color: Colors.black),
          computeCost(),
          Flexible(
              child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                products.isEmpty
                    ? const Text("")
                    : ElevatedButton(
                        onPressed: () {
                          context.read<ShoppingCart>().removeAll();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Payment Successful"),
                                  duration:
                                      Duration(seconds: 1, milliseconds: 100)));
                          Navigator.popUntil(context,
                              ModalRoute.withName(Navigator.defaultRouteName));
                        },
                        child: const Text("Pay Now!")),
              ]))),
        ],
      ),
    );
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return cart.cartTotal == 0
          ? Text("")
          : Text("Total Cost to Pay: ${cart.cartTotal}");
    });
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
        ? const Text('No items to checkout!')
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(products[index].name),
                    trailing: Text(products[index].price.toString()),
                  );
                },
              )),
            ],
          ));
  }
}
