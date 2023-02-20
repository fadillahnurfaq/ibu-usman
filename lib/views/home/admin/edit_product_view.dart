import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/admin/edit_product_controller.dart';
import 'package:ibu_usman/models/products_model.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/widgets/button/primary_button.dart';
import 'package:ibu_usman/shared/widgets/text_field/form_dropdown.dart';
import 'package:ibu_usman/shared/widgets/text_field/form_image_picker.dart';
import 'package:ibu_usman/shared/widgets/text_field/input_textfield.dart';

class EditProductView extends StatelessWidget {
  final ProductsModel product;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  EditProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    EditProductController.name.text = product.name!;
    EditProductController.price.text = product.price.toString();
    EditProductController.type = product.type!;
    EditProductController.photoUrl = product.photoUrl!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            EditProductController.clear();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Edit Menu"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: primaryPadding,
        child: Form(
          key: _formState,
          child: Column(
            children: [
              InputTextField(
                hintText: "Nama menu",
                controller: EditProductController.name,
                hide: true,
                massageValidator: "Nama menu tidak boleh kosong",
              ),
              InputTextField(
                hintText: "Harga",
                keyboardType: TextInputType.number,
                controller: EditProductController.price,
                hide: true,
                massageValidator: "Nama menu tidak boleh kosong",
              ),
              FormDropdown(
                items: const ["Makanan", "Minuman"],
                initialvalue: EditProductController.type,
                onChanged: (v) {
                  EditProductController.type = v;
                },
              ),
              FormImagePicker(
                label: "Foto",
                gallery: true,
                value: EditProductController.photoUrl,
                onChanged: (v) {
                  EditProductController.photoUrl = v;
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              PrimaryButton(
                label: "Simpan",
                onPressed: () async {
                  if (!_formState.currentState!.validate()) {
                    return;
                  } else {
                    await EditProductController.editProduct(id: product.id!);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
