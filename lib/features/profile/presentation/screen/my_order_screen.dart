import 'package:flutter/material.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with TickerProviderStateMixin {
  String selectedFilter = 'All';
  List<String> filters = ['All', 'Delivered', 'Pending', 'Cancelled'];
  TextEditingController searchController = TextEditingController();
  late AnimationController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    searchController.dispose();
    super.dispose();
  }

  // Sample order data
  List<Order> orders = [
    Order(
      id: '#ORD1245',
      dateTime: 'Sep 8, 2025 • 10:45 AM',
      status: OrderStatus.delivered,
      products: [
        Product('Fresh Milk', '🥛'),
        Product('Greek Yogurt', '🥛'),
        Product('Cheddar Cheese', '🧀'),
      ],
      totalPrice: 18.47,
    ),
    Order(
      id: '#ORD1244',
      dateTime: 'Sep 6, 2025 • 2:30 PM',
      status: OrderStatus.pending,
      products: [
        Product('Organic Butter', '🧈'),
        Product('Whole Milk', '🥛'),
      ],
      totalPrice: 12.99,
    ),
    Order(
      id: '#ORD1243',
      dateTime: 'Sep 4, 2025 • 8:15 AM',
      status: OrderStatus.cancelled,
      products: [
        Product('Cottage Cheese', '🧀'),
        Product('Heavy Cream', '🥛'),
        Product('Mozzarella', '🧀'),
        Product('Parmesan', '🧀'),
      ],
      totalPrice: 24.85,
    ),
    Order(
      id: '#ORD1242',
      dateTime: 'Sep 2, 2025 • 11:20 AM',
      status: OrderStatus.delivered,
      products: [
        Product('Almond Milk', '🥛'),
        Product('Oat Milk', '🥛'),
      ],
      totalPrice: 15.30,
    ),
    Order(
      id: '#ORD1241',
      dateTime: 'Aug 30, 2025 • 4:45 PM',
      status: OrderStatus.delivered,
      products: [
        Product('Ice Cream', '🍦'),
        Product('Yogurt Drinks', '🥛'),
        Product('Cream Cheese', '🧀'),
      ],
      totalPrice: 22.15,
    ),
  ];

  List<Order> get filteredOrders {
    List<Order> filtered = orders;

    // Filter by status
    if (selectedFilter != 'All') {
      OrderStatus status = OrderStatus.values.firstWhere(
              (s) => s.toString().split('.').last.toLowerCase() == selectedFilter.toLowerCase()
      );
      filtered = filtered.where((order) => order.status == status).toList();
    }

    // Filter by search
    if (searchController.text.isNotEmpty) {
      filtered = filtered.where((order) =>
      order.id.toLowerCase().contains(searchController.text.toLowerCase()) ||
          order.products.any((product) =>
              product.name.toLowerCase().contains(searchController.text.toLowerCase())
          )
      ).toList();
    }

    return filtered;
  }

  Future<void> _onRefresh() async {
    _refreshController.forward();
    await Future.delayed(Duration(seconds: 1));
    _refreshController.reset();
    // Simulate data refresh
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8F9FA),
        elevation: 0,
        title: Text(
          'My Orders',
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search orders...',
                  hintStyle: TextStyle(color: Color(0xFF666666)),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF666666)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),

          // Filter Chips
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;

                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color(0xFF666666),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Color(0xFF2E7D32),
                    checkmarkColor: Colors.white,
                    side: BorderSide(
                      color: isSelected ? Color(0xFF2E7D32) : Color(0xFFE0E0E0),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 16),

          // Orders List
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: Color(0xFF2E7D32),
              child: filteredOrders.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: Color(0xFF666666),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No orders found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: OrderCard(
                      order: order,
                      onViewDetails: () => _showOrderDetails(order),
                      onReorder: () => _reorder(order),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(Order order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OrderDetailsModal(order: order),
    );
  }

  void _reorder(Order order) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${order.products.length} items to cart'),
        backgroundColor: Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onViewDetails;
  final VoidCallback onReorder;

  const OrderCard({
    Key? key,
    required this.order,
    required this.onViewDetails,
    required this.onReorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.id,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                StatusChip(status: order.status),
              ],
            ),

            SizedBox(height: 8),

            Text(
              order.dateTime,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),

            SizedBox(height: 16),

            // Products
            _buildProductsList(),

            SizedBox(height: 16),

            // Total and Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${order.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: onViewDetails,
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (order.status == OrderStatus.delivered)
                      ElevatedButton(
                        onPressed: onReorder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2E7D32),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: Text('Reorder'),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsList() {
    final displayProducts = order.products.take(2).toList();
    final remainingCount = order.products.length - displayProducts.length;

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        ...displayProducts.map((product) => Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(product.emoji, style: TextStyle(fontSize: 16)),
              SizedBox(width: 6),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
        )),
        if (remainingCount > 0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFF2E7D32).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '+$remainingCount more',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

class StatusChip extends StatelessWidget {
  final OrderStatus status;

  const StatusChip({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (status) {
      case OrderStatus.delivered:
        backgroundColor = Color(0xFF4CAF50);
        textColor = Colors.white;
        statusText = 'Delivered';
        break;
      case OrderStatus.pending:
        backgroundColor = Color(0xFFFF9800);
        textColor = Colors.white;
        statusText = 'Pending';
        break;
      case OrderStatus.cancelled:
        backgroundColor = Color(0xFFE53935);
        textColor = Colors.white;
        statusText = 'Cancelled';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class OrderDetailsModal extends StatelessWidget {
  final Order order;

  const OrderDetailsModal({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
              ),
            ],
          ),

          SizedBox(height: 16),

          Text('Order ID: ${order.id}', style: TextStyle(fontSize: 16)),
          Text('Date: ${order.dateTime}', style: TextStyle(fontSize: 16)),

          SizedBox(height: 16),

          Text(
            'Items:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 8),

          ...order.products.map((product) => Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(product.emoji, style: TextStyle(fontSize: 20)),
                SizedBox(width: 12),
                Text(product.name, style: TextStyle(fontSize: 16)),
              ],
            ),
          )),

          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${order.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StatusChip(status: order.status),
            ],
          ),
        ],
      ),
    );
  }
}

// Data Models
enum OrderStatus { delivered, pending, cancelled }

class Order {
  final String id;
  final String dateTime;
  final OrderStatus status;
  final List<Product> products;
  final double totalPrice;

  Order({
    required this.id,
    required this.dateTime,
    required this.status,
    required this.products,
    required this.totalPrice,
  });
}

class Product {
  final String name;
  final String emoji;

  Product(this.name, this.emoji);
}