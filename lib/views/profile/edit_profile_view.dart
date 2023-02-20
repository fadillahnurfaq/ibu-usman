import 'package:flutter/material.dart';
import 'package:ibu_usman/controllers/profile/edit_profile_controller.dart';
import 'package:ibu_usman/shared/utils/style/size.dart';
import 'package:ibu_usman/shared/widgets/text_field/form_image_picker.dart';
import 'package:ibu_usman/shared/widgets/text_field/input_textfield.dart';
import 'package:ibu_usman/shared/widgets/text_field/phone_textfield.dart';

import '../../models/user_model.dart';
import '../../shared/utils/utility/show_alert.dart';

class EditProfileView extends StatefulWidget {
  final UserModel data;
  const EditProfileView({super.key, required this.data});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    EditProfileController.init(widget.data);
    super.initState();
  }

  @override
  void dispose() {
    EditProfileController.disposes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perbarui Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (!_formState.currentState!.validate()) {
                return;
              } else if (widget.data.photo == "") {
                showAlert("Oppsss", "Periksa kembali inputan anda.");
              } else {
                EditProfileController.updateProfile();
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: primaryPadding,
        child: Form(
          key: _formState,
          child: Column(
            children: [
              FormImagePicker(
                label: "Foto Profile",
                value: EditProfileController.photo,
                onChanged: (v) {
                  EditProfileController.photo = v;
                },
              ),
              InputTextField(
                hintText: "Nama anda",
                massageValidator: "Nama tidak boleh kosong",
                controller: EditProfileController.name,
                hide: true,
              ),
              PhoneTextField(
                hintText: "Nomor Telepon",
                keyboardType: TextInputType.phone,
                massageValidator: "Nomor Telepon tidak boleh kosong",
                controller: EditProfileController.phoneNumber,
                hide: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
