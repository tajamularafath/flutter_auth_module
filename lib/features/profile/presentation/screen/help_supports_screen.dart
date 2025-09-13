import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  @override
  _HelpSupportScreenState createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sample FAQ data
  final List<Map<String, String>> _faqs = [
    {
      'question': 'Where is my order?',
      'answer': 'You can track your order in the "My Orders" section. Go to Profile > My Orders and tap on your recent order to see real-time tracking information.'
    },
    {
      'question': 'How do I change my delivery address?',
      'answer': 'To update your delivery address, go to Profile > Delivery Addresses. You can add, edit, or delete addresses. Changes will apply to your next order.'
    },
    {
      'question': 'How do I update payment methods?',
      'answer': 'Navigate to Profile > Payment Methods to add new cards, update existing ones, or change your default payment method. All changes are secured with bank-level encryption.'
    },
    {
      'question': 'What if I received a wrong or damaged product?',
      'answer': 'We apologize for any inconvenience. Please contact our support team immediately with photos of the damaged items. We\'ll arrange a replacement or full refund within 24 hours.'
    },
    {
      'question': 'How do I cancel my order?',
      'answer': 'Orders can be cancelled within 30 minutes of placement. Go to My Orders, find your order, and tap "Cancel Order". After this window, please contact support for assistance.'
    },
    {
      'question': 'What are your delivery hours?',
      'answer': 'We deliver Monday to Saturday, 8 AM to 8 PM. Sunday deliveries are available in select areas from 10 AM to 6 PM.'
    }
  ];

  // Sample support tickets
  final List<Map<String, dynamic>> _supportTickets = [
    {
      'id': '#DAIRY-2024-001',
      'title': 'Damaged milk bottles in order',
      'status': 'Resolved',
      'date': '2024-01-15',
      'statusColor': Colors.green
    },
    {
      'id': '#DAIRY-2024-002',
      'title': 'Payment not processed',
      'status': 'In Progress',
      'date': '2024-01-18',
      'statusColor': Colors.orange
    },
    {
      'id': '#DAIRY-2024-003',
      'title': 'Late delivery complaint',
      'status': 'Pending',
      'date': '2024-01-20',
      'statusColor': Colors.blue
    }
  ];

  List<Map<String, String>> get filteredFAQs {
    if (_searchQuery.isEmpty) return _faqs;
    return _faqs.where((faq) =>
    faq['question']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        faq['answer']!.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2D3748)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickHelpSection(),
            const SizedBox(height: 24),
            _buildContactSupportSection(),
            const SizedBox(height: 24),
            _buildSubmitRequestSection(),
            const SizedBox(height: 24),
            _buildSupportTicketsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickHelpSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF68D391).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.help_outline,
                    color: Color(0xFF38A169),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Quick Help (FAQs)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search for help...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFF718096)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...filteredFAQs.map((faq) => _buildFAQItem(faq)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, String> faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          faq['question']!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D3748),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              faq['answer']!,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4A5568),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSupportSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF63B3ED).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.support_agent,
                    color: Color(0xFF3182CE),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Contact Support',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildContactOption(
                    icon: Icons.chat_bubble_outline,
                    label: 'Live Chat',
                    subtitle: 'Chat with us now',
                    color: const Color(0xFF38A169),
                    onTap: () => _startLiveChat(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildContactOption(
                    icon: Icons.phone_outlined,
                    label: 'Call Us',
                    subtitle: '+1-800-DAIRY-HELP',
                    color: const Color(0xFF3182CE),
                    onTap: () => _makePhoneCall(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildContactOption(
              icon: Icons.email_outlined,
              label: 'Email Support',
              subtitle: 'support@dairyfresh.com',
              color: const Color(0xFF805AD5),
              onTap: () => _sendEmail(),
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    bool isFullWidth = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: isFullWidth
            ? Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A5568),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
            : Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF4A5568),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitRequestSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFED8936).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.report_problem_outlined,
                    color: Color(0xFFDD6B20),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Submit a Request',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showSubmitRequestDialog(),
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Report a Problem'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDD6B20),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportTicketsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF805AD5).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.history,
                    color: Color(0xFF553C9A),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Previous Inquiries',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._supportTickets.map((ticket) => _buildTicketItem(ticket)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketItem(Map<String, dynamic> ticket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket['id'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A5568),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ticket['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ticket['date'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ticket['statusColor'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              ticket['status'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: ticket['statusColor'],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startLiveChat() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Starting live chat...'),
        backgroundColor: Color(0xFF38A169),
      ),
    );
  }

  void _makePhoneCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening phone dialer...'),
        backgroundColor: Color(0xFF3182CE),
      ),
    );
  }

  void _sendEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening email app...'),
        backgroundColor: Color(0xFF805AD5),
      ),
    );
  }

  void _showSubmitRequestDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            'Submit a Request',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Choose a category for your request:'),
              const SizedBox(height: 16),
              _buildCategoryOption('Delivery Issues', Icons.local_shipping),
              _buildCategoryOption('Payment Problems', Icons.payment),
              _buildCategoryOption('Product Issues', Icons.inventory_2),
              _buildCategoryOption('Other', Icons.help_outline),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoryOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4A5568)),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening $title request form...'),
            backgroundColor: const Color(0xFFDD6B20),
          ),
        );
      },
      contentPadding: EdgeInsets.zero,
    );
  }
}