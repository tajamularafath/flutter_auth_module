import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });
}

enum NotificationType { orders, offers, updates, general }

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<NotificationModel> _allNotifications = [];
  List<NotificationModel> _filteredNotifications = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_filterNotifications);
    _initializeNotifications();
    _filterNotifications();
  }

  void _initializeNotifications() {
    _allNotifications = [
      NotificationModel(
        id: '1',
        title: 'Order Delivered Successfully!',
        message: 'Your fresh milk and cheese have been delivered to your doorstep.',
        timestamp: DateTime.now().subtract(Duration(minutes: 30)),
        type: NotificationType.orders,
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: '20% Off on Premium Yogurt',
        message: 'Limited time offer! Get 20% discount on all Greek yogurt varieties.',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        type: NotificationType.offers,
        isRead: false,
      ),
      NotificationModel(
        id: '3',
        title: 'Order Shipped',
        message: 'Your order #DY2024-001 is on its way! Track your delivery.',
        timestamp: DateTime.now().subtract(Duration(hours: 5)),
        type: NotificationType.orders,
        isRead: true,
      ),
      NotificationModel(
        id: '4',
        title: 'New Organic Collection Available',
        message: 'Discover our new range of organic dairy products now in stock.',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        type: NotificationType.updates,
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        title: 'Weekend Special: Buy 2 Get 1',
        message: 'This weekend only! Buy 2 milk bottles and get 1 free.',
        timestamp: DateTime.now().subtract(Duration(days: 2)),
        type: NotificationType.offers,
        isRead: false,
      ),
      NotificationModel(
        id: '6',
        title: 'Payment Successful',
        message: 'Your payment of \$24.99 has been processed successfully.',
        timestamp: DateTime.now().subtract(Duration(days: 3)),
        type: NotificationType.orders,
        isRead: true,
      ),
    ];
  }

  void _filterNotifications() {
    setState(() {
      switch (_tabController.index) {
        case 0: // All
          _filteredNotifications = List.from(_allNotifications);
          break;
        case 1: // Orders
          _filteredNotifications = _allNotifications
              .where((n) => n.type == NotificationType.orders)
              .toList();
          break;
        case 2: // Offers
          _filteredNotifications = _allNotifications
              .where((n) => n.type == NotificationType.offers)
              .toList();
          break;
        case 3: // Updates
          _filteredNotifications = _allNotifications
              .where((n) => n.type == NotificationType.updates)
              .toList();
          break;
      }
    });
  }

  void _markAsRead(String id) {
    setState(() {
      final notification = _allNotifications.firstWhere((n) => n.id == id);
      notification.isRead = true;
    });
  }

  void _deleteNotification(String id) {
    setState(() {
      _allNotifications.removeWhere((n) => n.id == id);
      _filterNotifications();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification deleted'),
        backgroundColor: Colors.green[700],
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Clear All Notifications'),
          content: Text('Are you sure you want to delete all notifications?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _allNotifications.clear();
                  _filterNotifications();
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('All notifications cleared'),
                    backgroundColor: Colors.green[700],
                  ),
                );
              },
              child: Text('Clear All', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  String _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.orders:
        return '📦';
      case NotificationType.offers:
        return '💸';
      case NotificationType.updates:
        return '🔄';
      default:
        return '🧀';
    }
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  Future<void> _onRefresh() async {
    // Simulate network refresh
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // Add a new notification to simulate refresh
      _allNotifications.insert(
        0,
        NotificationModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'Fresh Update!',
          message: 'New dairy products added to your favorites.',
          timestamp: DateTime.now(),
          type: NotificationType.updates,
          isRead: false,
        ),
      );
      _filterNotifications();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF2E7D32),
        elevation: 0,
        actions: [
          if (_filteredNotifications.isNotEmpty)
            IconButton(
              onPressed: _clearAllNotifications,
              icon: Icon(Icons.clear_all, color: Colors.white),
              tooltip: 'Clear All',
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Orders'),
            Tab(text: 'Offers'),
            Tab(text: 'Updates'),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Color(0xFF2E7D32),
        child: _filteredNotifications.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_none,
                size: 80,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16),
              Text(
                'No notifications yet',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We\'ll notify you when something happens',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: _filteredNotifications.length,
          itemBuilder: (context, index) {
            final notification = _filteredNotifications[index];
            return Dismissible(
              key: Key(notification.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _deleteNotification(notification.id);
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: notification.isRead
                      ? Colors.white
                      : Color(0xFFF1F8E9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: notification.isRead
                      ? null
                      : Border.all(color: Color(0xFF2E7D32).withOpacity(0.2)),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF2E7D32).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        _getNotificationIcon(notification.type),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Color(0xFF2E7D32),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _getTimeAgo(notification.timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (!notification.isRead) {
                      _markAsRead(notification.id);
                    }
                    // Handle notification tap (navigate to relevant screen)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Opened: ${notification.title}'),
                        backgroundColor: Color(0xFF2E7D32),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}