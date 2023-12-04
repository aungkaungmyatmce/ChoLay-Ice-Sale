import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/screens/setting/product_names/product_edit_widget.dart';
import 'package:cholay_ice_sale/screens/setting/product_names/product_names_viewmodel.dart';
import 'package:cholay_ice_sale/widgets/body_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/decoration.dart';
import '../../../common/constants/style.dart';
import '../../../common/constants/translation_constants.dart';
import '../../../core/models/product.dart';
import '../../../core/services/confirm_delete_tran.dart';

class ProductNamesView extends StatelessWidget {
  const ProductNamesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductNamesViewModel productNamesViewModel =
        Provider.of<ProductNamesViewModel>(context);
    List<Product> productList = productNamesViewModel.productList;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: AppBar(
          title: Text(
            TranslationConstants.products.t(context),
            style: boldTextStyle(size: 16, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductEditScreen(
                            productNamesViewModel: productNamesViewModel),
                      ));
                },
                icon: const Icon(Icons.add, color: Colors.white)),
            const SizedBox(width: 10),
          ],
        ),
        body: BodyWidget(
          appError: productNamesViewModel.appError,
          child: Container(
            //margin: EdgeInsets.only(top: 90),
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 3),
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            return Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width - 20,
                                margin: const EdgeInsets.all(3),
                                padding: const EdgeInsets.all(5),
                                decoration: boxDecorationRoundedWithShadow(10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            child: Text(
                                              '  ${index + 1}. ${productList[index].name}',
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              style: boldTextStyle(size: 15),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            height: 25,
                                            child: Text(
                                              '        Price: ${productList[index].price}',
                                              style:
                                                  secondaryTextStyle(size: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductEditScreen(
                                                        product:
                                                            productList[index],
                                                        productNamesViewModel:
                                                            productNamesViewModel),
                                              ));
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          if (await confirmDeleteTran(
                                              context)) {
                                            productNamesViewModel.deleteProduct(
                                                product: productList[index]);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  ],
                                ));
                          },
                        ),
                      ),
                      //const SizedBox(height: 60),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
