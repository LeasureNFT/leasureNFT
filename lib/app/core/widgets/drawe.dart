import 'package:flutter/material.dart';


class Drawe extends StatelessWidget {
  const Drawe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pakistan Solar Market"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "PSM",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Pakistan Solar Market",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text("Profile Verify"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Add Data"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.view_list),
              title: const Text("Post View"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Add Data",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text("1. Add PDF"),
              children: [
                ListTile(
                  title: const Text("Option 1 Details"),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("2. Update Market Post"),
              children: [
                ListTile(
                  title: const Text("Option 2 Details"),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("3. Panel Categories"),
              children: [
                ListTile(
                  title: const Text("Option 3 Details"),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("4. Change Price"),
              children: [
                ListTile(
                  title: const Text("Option 4 Details"),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("5. Change Bid Price"),
              children: [
                ListTile(
                  title: const Text("Option 5 Details"),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("6. Add Location"),
              children: [
                ListTile(
                  title: const Text("Option 6 Details"),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("7. Add Brands"),
              children: [
                ListTile(
                  title: const Text("Option 7 Details"),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("8. Update Notification for User Update App"),
              children: [
                ListTile(
                  title: const Text("Option 8 Details"),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
