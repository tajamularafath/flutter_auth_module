import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  List<DeliveryAddress> addresses = [
    DeliveryAddress(
      id: '1',
      recipientName: 'John Doe',
      phoneNumber: '+91 9876543210',
      streetAddress: '123 Main Street, Apartment 4B',
      city: 'Chennai',
      state: 'Tamil Nadu',
      pincode: '600001',
      tag: 'Home',
      isDefault: true,
    ),
    DeliveryAddress(
      id: '2',
      recipientName: 'John Doe',
      phoneNumber: '+91 9876543210',
      streetAddress: '456 Business Park, 12th Floor',
      city: 'Chennai',
      state: 'Tamil Nadu',
      pincode: '600032',
      tag: 'Work',
      isDefault: false,
    ),
    DeliveryAddress(
      id: '3',
      recipientName: 'Sarah Doe',
      phoneNumber: '+91 9123456789',
      streetAddress: '789 Garden Colony, House No. 15',
      city: 'Coimbatore',
      state: 'Tamil Nadu',
      pincode: '641001',
      tag: 'Other',
      isDefault: false,
    ),
  ];

  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  List<DeliveryAddress> get filteredAddresses {
    if (searchQuery.isEmpty) return addresses;
    return addresses.where((address) {
      return address.recipientName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          address.streetAddress.toLowerCase().contains(searchQuery.toLowerCase()) ||
          address.city.toLowerCase().contains(searchQuery.toLowerCase()) ||
          address.tag.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          'Delivery Addresses',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search Bar (if more than 2 addresses)
          if (addresses.length > 2) _buildSearchBar(),
          // Addresses List
          Expanded(
            child: addresses.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredAddresses.length,
              itemBuilder: (context, index) {
                return AddressCard(
                  address: filteredAddresses[index],
                  onEdit: () => _editAddress(filteredAddresses[index]),
                  onDelete: () => _deleteAddress(filteredAddresses[index]),
                  onSetDefault: () => _setDefaultAddress(filteredAddresses[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewAddress,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        label: const Text(
          'Add New Address',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search addresses...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No delivery addresses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first delivery address to get started',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _addNewAddress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditAddressScreen(
          onSave: (address) {
            setState(() {
              // If this is the first address, make it default
              if (addresses.isEmpty) {
                address.isDefault = true;
              }
              addresses.add(address);
            });
            _showSnackBar('Address added successfully', Colors.green);
          },
        ),
      ),
    );
  }

  void _editAddress(DeliveryAddress address) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditAddressScreen(
          address: address,
          onSave: (updatedAddress) {
            setState(() {
              int index = addresses.indexWhere((a) => a.id == address.id);
              if (index != -1) {
                addresses[index] = updatedAddress;
              }
            });
            _showSnackBar('Address updated successfully', Colors.green);
          },
        ),
      ),
    );
  }

  void _deleteAddress(DeliveryAddress address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Address'),
        content: const Text('Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                addresses.removeWhere((a) => a.id == address.id);
                // If deleted address was default, make first address default
                if (address.isDefault && addresses.isNotEmpty) {
                  addresses.first.isDefault = true;
                }
              });
              _showSnackBar('Address deleted', Colors.red);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _setDefaultAddress(DeliveryAddress address) {
    setState(() {
      // Remove default from all addresses
      for (var addr in addresses) {
        addr.isDefault = false;
      }
      // Set selected address as default
      address.isDefault = true;
    });
    _showSnackBar('Default address updated', Colors.green);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final DeliveryAddress address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  const AddressCard({
    Key? key,
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getTagColor(address.tag).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          address.tag,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _getTagColor(address.tag),
                          ),
                        ),
                      ),
                      if (address.isDefault) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'DEFAULT',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      color: Colors.grey[600],
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, size: 20),
                      color: Colors.red[400],
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Recipient Name
            Text(
              address.recipientName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            // Phone Number
            Text(
              address.phoneNumber,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            // Full Address
            Text(
              '${address.streetAddress}, ${address.city}, ${address.state} - ${address.pincode}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
            if (!address.isDefault) ...[
              const SizedBox(height: 12),
              // Set as Default Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onSetDefault,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2E7D32),
                    side: const BorderSide(color: Color(0xFF2E7D32)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    'Set as Default',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'home':
        return Colors.blue;
      case 'work':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }
}

class AddEditAddressScreen extends StatefulWidget {
  final DeliveryAddress? address;
  final Function(DeliveryAddress) onSave;

  const AddEditAddressScreen({
    Key? key,
    this.address,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();

  String selectedTag = 'Home';
  bool setAsDefault = false;
  final List<String> addressTags = ['Home', 'Work', 'Other'];

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      _nameController.text = widget.address!.recipientName;
      _phoneController.text = widget.address!.phoneNumber;
      _streetController.text = widget.address!.streetAddress;
      _cityController.text = widget.address!.city;
      _stateController.text = widget.address!.state;
      _pincodeController.text = widget.address!.pincode;
      selectedTag = widget.address!.tag;
      setAsDefault = widget.address!.isDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.address != null;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Address' : 'Add New Address',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter full name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _phoneController,
              label: 'Mobile Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter mobile number';
                }
                if (value.length != 10) {
                  return 'Please enter valid 10-digit mobile number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _streetController,
              label: 'Street Address',
              icon: Icons.location_on_outlined,
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter street address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _cityController,
                    label: 'City',
                    icon: Icons.location_city_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter city';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _stateController,
                    label: 'State',
                    icon: Icons.map_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter state';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _pincodeController,
              label: 'Pincode',
              icon: Icons.local_post_office_outlined,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter pincode';
                }
                if (value.length != 6) {
                  return 'Please enter valid 6-digit pincode';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            // Address Tag Selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Address Tag',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: addressTags.map((tag) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTag = tag;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selectedTag == tag
                                  ? const Color(0xFF2E7D32).withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selectedTag == tag
                                    ? const Color(0xFF2E7D32)
                                    : Colors.transparent,
                              ),
                            ),
                            child: Text(
                              tag,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: selectedTag == tag
                                    ? const Color(0xFF2E7D32)
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Set as Default Checkbox
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CheckboxListTile(
                title: const Text(
                  'Set as default address',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: const Text(
                  'This address will be selected by default for new orders',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                value: setAsDefault,
                onChanged: (value) {
                  setState(() {
                    setAsDefault = value ?? false;
                  });
                },
                activeColor: const Color(0xFF2E7D32),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 32),
            // Save Button
            ElevatedButton(
              onPressed: _saveAddress,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                isEditing ? 'Update Address' : 'Save Address',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2E7D32)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final address = DeliveryAddress(
        id: widget.address?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        recipientName: _nameController.text.trim(),
        phoneNumber: '+91 ${_phoneController.text.trim()}',
        streetAddress: _streetController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        pincode: _pincodeController.text.trim(),
        tag: selectedTag,
        isDefault: setAsDefault,
      );

      widget.onSave(address);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }
}

class DeliveryAddress {
  final String id;
  final String recipientName;
  final String phoneNumber;
  final String streetAddress;
  final String city;
  final String state;
  final String pincode;
  final String tag;
  bool isDefault;

  DeliveryAddress({
    required this.id,
    required this.recipientName,
    required this.phoneNumber,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.pincode,
    required this.tag,
    required this.isDefault,
  });
}