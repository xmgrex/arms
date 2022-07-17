import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/products/domain/sku.dart';
import 'package:arms/src/features/supplier/domain/supplier.dart';
import 'package:arms/src/features/supplier/presentation/supplier_list/select_sku_widget.dart';
import 'package:arms/src/features/supplier/presentation/supplier_list/supplier_list_builder.dart';
import 'package:arms/src/features/supplier/presentation/supplier_list/supplier_list_ittem.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../domain/supplier.dart';

class NearBySuppliersListScreen extends StatelessWidget {
  const NearBySuppliersListScreen(
      {Key? key, required this.suppliersList, required this.sku})
      : super(key: key);

  final List<Supplier> suppliersList;
  final SKU sku;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backPageButton(context: context),
        title: Text(S.of(context).searchByOtherCars),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectSKU(sku: sku),
            SupplierListBuilder(
              suppliers: suppliersList,
              builder: (context, index, supplier) {
                return SupplierListItem(
                  supplier: supplier,
                  sku: sku,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
