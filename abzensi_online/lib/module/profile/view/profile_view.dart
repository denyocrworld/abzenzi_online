import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../../../service/auth_service/auth_service.dart';
import '../controller/profile_controller.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  Widget build(context, ProfileController controller) {
    controller.view = this;

    // if (controller.user == null) return LoadingWidget();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => controller.doLogout(),
            icon: Icon(
              Icons.logout,
              size: 24.0,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              if (controller.user != null) ...[
                QImagePicker(
                  label: "Photo",
                  validator: Validator.required,
                  value: controller.user?.photo,
                  onChanged: (value) {
                    controller.photo = value;
                  },
                ),
                QTextField(
                  label: "Name",
                  validator: Validator.required,
                  value: controller.user?.name,
                  onChanged: (value) {
                    controller.name = value;
                  },
                ),
                QTextField(
                  label: "Email",
                  validator: Validator.required,
                  value: controller.user?.email,
                  enabled: false,
                  onChanged: (value) {},
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: QActionButton(
        label: "Save",
        onPressed: () => controller.updateUser(),
      ),
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}
