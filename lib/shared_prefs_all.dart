import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Home Page Screen
class SharedPrefeceALL extends StatefulWidget {
  const SharedPrefeceALL({super.key});

  @override
  State<SharedPrefeceALL> createState() => _SharedPrefeceALLState();
}

class _SharedPrefeceALLState extends State<SharedPrefeceALL> {
  final TextEditingController tcName = TextEditingController();
  final TextEditingController tcCellNo = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call the getData method when the screen is initialized
    // This will load any saved data into the text fields if available.
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences Complete"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name input field
              TextField(
                controller: tcName,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 16),
              // Cell number input field
              TextField(
                controller: tcCellNo,
                decoration: InputDecoration(
                  labelText: 'Cell Number',
                  hintText: 'Enter your cell number',
                ),
              ),
              SizedBox(height: 20),
              // Button to save data
              ElevatedButton(
                onPressed: saveData,
                child: Text("Save Data"),
              ),
              SizedBox(height: 10),
              // Button to remove name only
              ElevatedButton(
                onPressed: removeName,
                child: Text("Remove Name Only"),
              ),
              SizedBox(height: 10),
              // Button to remove cell number only
              ElevatedButton(
                onPressed: removeCallno,
                child: Text("Remove Cell Number Only"),
              ),
              SizedBox(height: 10),
              // Button to clear all saved data
              ElevatedButton(
                onPressed: clearAllData,
                child: Text("Clear All Data"),
              ),
              SizedBox(height: 20),
              // Button to navigate to the 'View All Records' screen
              ElevatedButton(
                onPressed: () {
                  // Navigate to the new screen to view saved records
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewAllRecordsScreen(),
                    ),
                  );
                },
                child: Text("View All Records"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ====================
  // Save Data to SharedPreferences
  // ====================
  void saveData() async {
    // Retrieve SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save name and cell number in SharedPreferences
    await prefs.setString('name', tcName.text);
    await prefs.setString('cellno', tcCellNo.text);
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data Saved Successfully")),
    );
  }

  // ====================
  // Get Data from SharedPreferences
  // ====================
  void getData() async {
    // Retrieve SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load saved data into text fields, if available
    tcName.text = prefs.getString('name') ?? "";
    tcCellNo.text = prefs.getString('cellno') ?? "";
  }

  // ====================
  // Remove Name from SharedPreferences
  // ====================
  void removeName() async {
    // Retrieve SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Remove only the 'name' key from SharedPreferences
    await prefs.remove('name');
    tcName.clear(); // Clear the name field in UI
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Name Removed")),
    );
  }

  // ====================
  // Remove Cell Number from SharedPreferences
  // ====================
  void removeCallno() async {
    // Retrieve SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Remove only the 'cellno' key from SharedPreferences
    await prefs.remove('cellno');
    tcCellNo.clear(); // Clear the cell number field in UI
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Cell Number Removed")),
    );
  }

  // ====================
  // Clear All Data from SharedPreferences
  // ====================
  void clearAllData() async {
    // Retrieve SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Clear all saved data from SharedPreferences
    await prefs.clear();
    tcName.clear(); // Clear the name field in UI
    tcCellNo.clear(); // Clear the cell number field in UI
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("All Data Cleared")),
    );
  }
}

// View All Records Screen
class ViewAllRecordsScreen extends StatefulWidget {
  @override
  _ViewAllRecordsScreenState createState() => _ViewAllRecordsScreenState();
}

class _ViewAllRecordsScreenState extends State<ViewAllRecordsScreen> {
  String name = "";
  String cellno = "";

  @override
  void initState() {
    super.initState();
    // Load data when the screen is initialized
    loadData();
  }

  // ====================
  // Load Data from SharedPreferences
  // ====================
  void loadData() async {
    // Retrieve SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load the saved name and cell number into local variables
    setState(() {
      name = prefs.getString('name') ?? "No name saved";
      cellno = prefs.getString('cellno') ?? "No cell number saved";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Saved Records"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the saved name
            Text(
              "Name: $name",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            // Display the saved cell number
            Text(
              "Cell Number: $cellno",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
