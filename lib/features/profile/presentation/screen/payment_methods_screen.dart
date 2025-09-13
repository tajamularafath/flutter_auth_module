import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: '1',
      type: PaymentType.card,
      title: 'Visa Card',
      subtitle: '**** **** **** 4532',
      icon: Icons.credit_card,
      color: Color(0xFF1A1F71),
      isDefault: true,
    ),
    PaymentMethod(
      id: '2',
      type: PaymentType.upi,
      title: 'UPI ID',
      subtitle: 'user@paytm',
      icon: Icons.account_balance,
      color: Color(0xFF00BAF2),
      isDefault: false,
    ),
    PaymentMethod(
      id: '3',
      type: PaymentType.wallet,
      title: 'Google Pay',
      subtitle: 'Connected',
      icon: Icons.account_balance_wallet,
      color: Color(0xFF4285F4),
      isDefault: false,
    ),
  ];

  bool cashOnDeliveryEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('Payment Methods'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your Payment Methods Section
            _buildSectionHeader('Your Payment Methods'),
            SizedBox(height: 12),

            // Payment Methods List
            ...paymentMethods.map((method) => _buildPaymentMethodCard(method)).toList(),

            // Cash on Delivery Option
            _buildCashOnDeliveryCard(),

            SizedBox(height: 24),

            // Add New Payment Method
            _buildAddNewSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Payment Method Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: method.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                method.icon,
                color: method.color,
                size: 24,
              ),
            ),

            SizedBox(width: 16),

            // Payment Method Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        method.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      if (method.isDefault) ...[
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFF2E7D32),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    method.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Actions
            PopupMenuButton<String>(
              onSelected: (value) => _handlePaymentMethodAction(value, method),
              itemBuilder: (context) => [
                if (!method.isDefault)
                  PopupMenuItem(
                    value: 'set_default',
                    child: Row(
                      children: [
                        Icon(Icons.radio_button_checked, size: 20, color: Color(0xFF2E7D32)),
                        SizedBox(width: 8),
                        Text('Set as Default'),
                      ],
                    ),
                  ),
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'remove',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Remove'),
                    ],
                  ),
                ),
              ],
              child: Icon(Icons.more_vert, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCashOnDeliveryCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.local_shipping,
                color: Color(0xFF2E7D32),
                size: 24,
              ),
            ),

            SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cash on Delivery',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pay when you receive your order',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            Switch(
              value: cashOnDeliveryEnabled,
              onChanged: (value) {
                setState(() {
                  cashOnDeliveryEnabled = value;
                });
              },
              activeColor: Color(0xFF2E7D32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Add New Payment Method'),
        SizedBox(height: 12),

        // Add New Payment Method Button
        InkWell(
          onTap: _showAddPaymentMethodOptions,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF2E7D32), width: 2),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.add,
                    size: 32,
                    color: Color(0xFF2E7D32),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add Payment Method',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handlePaymentMethodAction(String action, PaymentMethod method) {
    switch (action) {
      case 'set_default':
        setState(() {
          for (var pm in paymentMethods) {
            pm.isDefault = pm.id == method.id;
          }
        });
        _showSnackBar('${method.title} set as default payment method');
        break;
      case 'edit':
        _editPaymentMethod(method);
        break;
      case 'remove':
        _confirmRemovePaymentMethod(method);
        break;
    }
  }

  void _editPaymentMethod(PaymentMethod method) {
    // Implement edit functionality based on payment type
    if (method.type == PaymentType.card) {
      _showAddCardDialog(editingMethod: method);
    } else if (method.type == PaymentType.upi) {
      _showAddUPIDialog(editingMethod: method);
    }
  }

  void _confirmRemovePaymentMethod(PaymentMethod method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Payment Method'),
        content: Text('Are you sure you want to remove ${method.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                paymentMethods.removeWhere((pm) => pm.id == method.id);
              });
              Navigator.pop(context);
              _showSnackBar('${method.title} removed successfully');
            },
            child: Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAddPaymentMethodOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Add Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),

            _buildPaymentOption(
              icon: Icons.credit_card,
              title: 'Credit/Debit Card',
              subtitle: 'Add your card details securely',
              color: Color(0xFF1A1F71),
              onTap: () {
                Navigator.pop(context);
                _showAddCardDialog();
              },
            ),

            _buildPaymentOption(
              icon: Icons.account_balance,
              title: 'UPI ID',
              subtitle: 'Add your UPI ID',
              color: Color(0xFF00BAF2),
              onTap: () {
                Navigator.pop(context);
                _showAddUPIDialog();
              },
            ),

            _buildPaymentOption(
              icon: Icons.account_balance_wallet,
              title: 'Digital Wallet',
              subtitle: 'Link Google Pay, Paytm, PhonePe',
              color: Color(0xFF4285F4),
              onTap: () {
                Navigator.pop(context);
                _showWalletOptions();
              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  void _showAddCardDialog({PaymentMethod? editingMethod}) {
    final _formKey = GlobalKey<FormState>();
    final _cardNumberController = TextEditingController(
      text: editingMethod?.type == PaymentType.card ? editingMethod!.subtitle.replaceAll('*', '').trim() : '',
    );
    final _expiryController = TextEditingController();
    final _cvvController = TextEditingController();
    final _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(editingMethod != null ? 'Edit Card' : 'Add Card'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  hintText: '1234 5678 9012 3456',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberInputFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.replaceAll(' ', '').length < 13) {
                    return 'Enter valid card number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryController,
                      decoration: InputDecoration(
                        labelText: 'MM/YY',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        _ExpiryDateInputFormatter(),
                      ],
                      validator: (value) {
                        if (value == null || value.length < 5) {
                          return 'Enter MM/YY';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return 'Enter CVV';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Cardholder Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter cardholder name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Add or update card
                final cardNumber = _cardNumberController.text.replaceAll(' ', '');
                final lastFour = cardNumber.substring(cardNumber.length - 4);

                if (editingMethod != null) {
                  setState(() {
                    editingMethod.subtitle = '**** **** **** $lastFour';
                  });
                  _showSnackBar('Card updated successfully');
                } else {
                  final newCard = PaymentMethod(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    type: PaymentType.card,
                    title: _getCardBrand(cardNumber),
                    subtitle: '**** **** **** $lastFour',
                    icon: Icons.credit_card,
                    color: Color(0xFF1A1F71),
                    isDefault: paymentMethods.isEmpty,
                  );
                  setState(() {
                    paymentMethods.add(newCard);
                  });
                  _showSnackBar('Card added successfully');
                }
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E7D32),
            ),
            child: Text(editingMethod != null ? 'Update' : 'Add Card'),
          ),
        ],
      ),
    );
  }

  void _showAddUPIDialog({PaymentMethod? editingMethod}) {
    final _upiController = TextEditingController(
      text: editingMethod?.subtitle ?? '',
    );
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(editingMethod != null ? 'Edit UPI ID' : 'Add UPI ID'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _upiController,
            decoration: InputDecoration(
              labelText: 'UPI ID',
              hintText: 'yourname@paytm',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Enter valid UPI ID';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (editingMethod != null) {
                  setState(() {
                    editingMethod.subtitle = _upiController.text;
                  });
                  _showSnackBar('UPI ID updated successfully');
                } else {
                  final newUPI = PaymentMethod(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    type: PaymentType.upi,
                    title: 'UPI ID',
                    subtitle: _upiController.text,
                    icon: Icons.account_balance,
                    color: Color(0xFF00BAF2),
                    isDefault: paymentMethods.isEmpty,
                  );
                  setState(() {
                    paymentMethods.add(newUPI);
                  });
                  _showSnackBar('UPI ID added successfully');
                }
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E7D32),
            ),
            child: Text(editingMethod != null ? 'Update' : 'Add UPI'),
          ),
        ],
      ),
    );
  }

  void _showWalletOptions() {
    final wallets = [
      {'name': 'Google Pay', 'color': Color(0xFF4285F4)},
      {'name': 'Paytm', 'color': Color(0xFF00BAF2)},
      {'name': 'PhonePe', 'color': Color(0xFF5F259F)},
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Wallet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            ...wallets.map((wallet) => ListTile(
              leading: CircleAvatar(
                backgroundColor: (wallet['color'] as Color).withOpacity(0.1),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: wallet['color'] as Color,
                ),
              ),
              title: Text(wallet['name'] as String),
              onTap: () {
                final newWallet = PaymentMethod(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  type: PaymentType.wallet,
                  title: wallet['name'] as String,
                  subtitle: 'Connected',
                  icon: Icons.account_balance_wallet,
                  color: wallet['color'] as Color,
                  isDefault: paymentMethods.isEmpty,
                );
                setState(() {
                  paymentMethods.add(newWallet);
                });
                Navigator.pop(context);
                _showSnackBar('${wallet['name']} added successfully');
              },
            )).toList(),
          ],
        ),
      ),
    );
  }

  String _getCardBrand(String cardNumber) {
    if (cardNumber.startsWith('4')) return 'Visa Card';
    if (cardNumber.startsWith('5')) return 'Mastercard';
    if (cardNumber.startsWith('3')) return 'American Express';
    return 'Credit Card';
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xFF2E7D32),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

// Data Models
enum PaymentType { card, upi, wallet }

class PaymentMethod {
  final String id;
  final PaymentType type;
  final String title;
  String subtitle;
  final IconData icon;
  final Color color;
  bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isDefault,
  });
}

// Input Formatters
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i + 1 != text.length) {
        buffer.write(' ');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2) {
        buffer.write('/');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}