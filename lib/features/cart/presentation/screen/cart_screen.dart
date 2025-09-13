import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      id: 1,
      name: 'Organic Whole Milk',
      price: 4.99,
      quantity: 2,
      emoji: '🥛',
    ),
    CartItem(
      id: 2,
      name: 'Greek Yogurt',
      price: 3.49,
      quantity: 1,
      emoji: '🥛',
    ),
    CartItem(
      id: 3,
      name: 'Aged Cheddar Cheese',
      price: 8.99,
      quantity: 1,
      emoji: '🧀',
    ),
  ];

  final double deliveryFee = 2.99;

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get total {
    return subtotal + deliveryFee;
  }

  void updateQuantity(int id, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        cartItems.removeWhere((item) => item.id == id);
      } else {
        final index = cartItems.indexWhere((item) => item.id == id);
        if (index != -1) {
          cartItems[index].quantity = newQuantity;
        }
      }
    });
  }

  void removeItem(int id) {
    setState(() {
      cartItems.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Continue shopping action
            },
            child: Text(
              'Continue',
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: cartItems.length,
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildCartItem(cartItems[index]);
              },
            ),
          ),
          _buildSummarySection(),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add some dairy products to get started',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          // Product Image/Emoji
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                item.emoji,
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
          SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '₹${item.price.toStringAsFixed(2)} each',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '₹${(item.price * item.quantity).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Column(
            children: [
              Row(
                children: [
                  _buildQuantityButton(
                    icon: Icons.remove,
                    onPressed: () => updateQuantity(item.id, item.quantity - 1),
                  ),
                  Container(
                    width: 40,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                  _buildQuantityButton(
                    icon: Icons.add,
                    onPressed: () => updateQuantity(item.id, item.quantity + 1),
                  ),
                ],
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () => removeItem(item.id),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Color(0xFF2E7D32),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Summary rows
          _buildSummaryRow('Subtotal', '₹${subtotal.toStringAsFixed(2)}'),
          SizedBox(height: 8),
          _buildSummaryRow('Delivery Fee', '₹${deliveryFee.toStringAsFixed(2)}'),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Colors.grey[300]),
          ),

          _buildSummaryRow(
            'Total Amount',
            '₹${total.toStringAsFixed(2)}',
            isTotal: true,
          ),

          SizedBox(height: 20),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: cartItems.isEmpty ? null : () {
                // Checkout action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Proceeding to checkout...'),
                    backgroundColor: Color(0xFF2E7D32),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? Colors.grey[800] : Colors.grey[600],
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            color: isTotal ? Color(0xFF2E7D32) : Colors.grey[800],
          ),
        ),
      ],
    );
  }
}

class CartItem {
  final int id;
  final String name;
  final double price;
  int quantity;
  final String emoji;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.emoji,
  });
}

// Usage example:
// To use this screen in your app, simply navigate to it:
// Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));