import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/screens/setting/product_names/product_names_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/decoration.dart';
import '../../../common/constants/style.dart';
import '../../../core/models/product.dart';

class ProductEditScreen extends StatefulWidget {
  final Product? product;
  final ProductNamesViewModel productNamesViewModel;
  const ProductEditScreen(
      {Key? key, this.product, required this.productNamesViewModel})
      : super(key: key);

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _form = GlobalKey<FormState>();
  final _dropdownState = GlobalKey<FormFieldState>();
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    if (widget.product != null) {
      _productNameController.text = widget.product!.name!;
      _priceController.text = widget.product!.price.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
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
    Product pro = Product(
      name: _productNameController.text,
      price: int.parse(_priceController.text),
    );

    await widget.productNamesViewModel
        .editProductList(newProduct: pro, oldProduct: widget.product);

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
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
                      'Add New Product',
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
                              controller: _productNameController,
                              decoration: const InputDecoration(
                                  labelText: 'Product Name'),
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
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Price',
                              ),
                              textInputAction: TextInputAction.next,
                              style: secondaryTextStyle(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter ph no';
                                }
                                return null;
                              },
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
      )),
    );
  }
}
