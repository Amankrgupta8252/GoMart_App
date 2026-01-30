import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(IconsaxPlusBold.user),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                controller: TextEditingController(text: "Aman Gupta"),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                controller: TextEditingController(text: "kraman@gmail.com"),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                controller: TextEditingController(text: "8252339216"),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Address",
                  prefixIcon: Icon(IconsaxPlusBold.location),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                controller: TextEditingController(text: "Sasaram, Bihar"),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  prefixIcon: Icon(Icons.date_range),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                controller: TextEditingController(text: "08/12/2004"),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Gender",
                  prefixIcon: Icon(Icons.man),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                controller: TextEditingController(text: "Male"),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    label: const Text(
                      "Add New Address",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
