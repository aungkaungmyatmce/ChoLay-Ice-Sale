import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/core/models/product.dart';
import 'package:cholay_ice_sale/screens/setting/customer_names/customer_names_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/decoration.dart';
import '../../../common/constants/style.dart';
import '../../../core/models/customer.dart';
import '../../../core/services/location_service.dart';

class CustomerEditScreen extends StatefulWidget {
  final Customer? customer;
  final CustomerNamesViewModel customerNamesViewModel;
  const CustomerEditScreen(
      {Key? key, this.customer, required this.customerNamesViewModel})
      : super(key: key);

  @override
  _CustomerEditScreenState createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends State<CustomerEditScreen> {
  final _form = GlobalKey<FormState>();
  final _dropdownState = GlobalKey<FormFieldState>();
  final _customerNameController = TextEditingController();
  final _latitudeNameController = TextEditingController();
  final _longitudeNameController = TextEditingController();
  final _phNoController = TextEditingController();
  late List<String> productNames;
  late String _productName;
  bool _isLoading = false;

  @override
  void initState() {
    productNames = widget.customerNamesViewModel.productList
        .map((pro) => pro.name)
        .toList();

    _productName = productNames.first;
    if (widget.customer != null) {
      _customerNameController.text = widget.customer!.name!;
      _phNoController.text = widget.customer!.phNo.toString();
      _latitudeNameController.text =
          widget.customer!.location.latitude.toString();
      _longitudeNameController.text =
          widget.customer!.location.longitude.toString();
      if (productNames.contains(widget.customer!.buyingProduct!)) {
        _productName = widget.customer!.buyingProduct!;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _phNoController.dispose();
    _latitudeNameController.dispose();
    _longitudeNameController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    final _isValid = _form.currentState!.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    });
    Customer cus = Customer(
      name: _customerNameController.text,
      buyingProduct: _productName,
      phNo: _phNoController.text,
      location: GeoPoint(double.parse(_latitudeNameController.text),
          double.parse(_longitudeNameController.text)),
    );

    await widget.customerNamesViewModel
        .editCustomerList(newCustomer: cus, oldCustomer: widget.customer);

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Container(
          decoration: boxDecorationWithRoundedCorners(
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(32))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 18,
                        )),
                    Text(
                      'Add New Customer',
                      style: boldTextStyle(size: 16),
                    )
                  ],
                ),
                const Divider(thickness: 1),
                Form(
                  key: _form,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            height: 60,
                            child: TextFormField(
                              //enabled: widget.setItem != null ? false : true,
                              controller: _customerNameController,
                              decoration: const InputDecoration(
                                  labelText: 'Customer Name'),
                              style: secondaryTextStyle(),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a name';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            height: 60,
                            child: TextFormField(
                              controller: _phNoController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Phone No',
                              ),
                              style: secondaryTextStyle(),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter ph no';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            height: 60,
                            child: DropdownButtonFormField(
                              key: _dropdownState,
                              isDense: false,
                              itemHeight: 50,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 5.5, 0, 0),
                                  labelStyle: secondaryTextStyle(),
                                  labelText: 'Buying Product'),
                              isExpanded: true,
                              items: productNames.map((String name) {
                                return DropdownMenuItem(
                                    value: name,
                                    child: Text(
                                      name,
                                      overflow: TextOverflow.ellipsis,
                                      style: secondaryTextStyle(),
                                    ));
                              }).toList(),
                              onChanged: (newValue) {
                                _productName = newValue.toString();
                              },
                              value: _productName,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  height: 60,
                                  child: TextFormField(
                                    //enabled: widget.setItem != null ? false : true,
                                    controller: _latitudeNameController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'Latitude'),
                                    style: secondaryTextStyle(),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter latitude';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  height: 60,
                                  child: TextFormField(
                                    //enabled: widget.setItem != null ? false : true,
                                    controller: _longitudeNameController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'Longitude'),
                                    style: secondaryTextStyle(),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter longitude';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .blueGrey, // Set the desired background color
                                    ),
                                    onPressed: () async {
                                      Position? curPosition =
                                          await LocationService
                                              .getCurrentLocation();
                                      if (curPosition != null) {
                                        _latitudeNameController.text =
                                            curPosition.latitude
                                                .toStringAsFixed(4);
                                        _longitudeNameController.text =
                                            curPosition.longitude
                                                .toStringAsFixed(4);
                                      }
                                    },
                                    child: _isLoading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                color: Colors.white),
                                          )
                                        : const Text('Get Location',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white))),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                              onPressed: () async {
                                _onSave();
                              },
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    )
                                  : const Text('Save',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
