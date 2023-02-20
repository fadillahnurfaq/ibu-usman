import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/home/admin/add_product_controller.dart';
import 'package:ibu_usman/shared/utils/state_util.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/utils/utility/show_alert.dart';
import 'package:ibu_usman/shared/widgets/button/primary_button.dart';
import 'package:ibu_usman/shared/widgets/text_field/form_dropdown.dart';
import 'package:ibu_usman/shared/widgets/text_field/form_image_picker.dart';
import 'package:ibu_usman/shared/widgets/text_field/input_textfield.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    AddProductController.init();
    super.initState();
  }

  @override
  void dispose() {
    AddProductController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Tambah Menu"),
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
                controller: AddProductController.name,
                hide: true,
                massageValidator: "Nama menu tidak boleh kosong",
              ),
              InputTextField(
                hintText: "Harga",
                keyboardType: TextInputType.number,
                controller: AddProductController.price,
                hide: true,
                massageValidator: "Nama menu tidak boleh kosong",
              ),
              FormDropdown(
                items: const ["Makanan", "Minuman"],
                onChanged: (v) {
                  AddProductController.type = v;
                },
              ),
              FormImagePicker(
                label: "Foto",
                onChanged: (v) {
                  AddProductController.photoUrl = v;
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
                  } else if (AddProductController.type == "" &&
                      AddProductController.photoUrl == "") {
                    showAlert("Oppsss", "Periksa kembali inputan anda.");
                  } else {
                    await AddProductController.addProduct();
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
