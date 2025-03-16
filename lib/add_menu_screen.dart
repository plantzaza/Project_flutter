import 'package:flutter/material.dart';

class AddMenuScreen extends StatefulWidget {
  final bool isEditing;
  final String initialTitle;
  final List<dynamic> initialIngredients;

  AddMenuScreen({
    this.isEditing = false,
    this.initialTitle = '',
    this.initialIngredients = const [],
  });

  @override
  _AddMenuScreenState createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  late TextEditingController _titleController;
  List<IngredientItem> _ingredients = [];
  final List<String> _units = ['g', 'kg', 'ml', 'L', 'ช้อนชา', 'ช้อนโต๊ะ', 'ถ้วย', 'ชิ้น', 'อื่นๆ'];
  
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    
    if (widget.initialIngredients.isNotEmpty) {
      for (var ingredient in widget.initialIngredients) {
        _ingredients.add(
          IngredientItem(
            name: ingredient['name'] ?? '',
            amount: ingredient['amount']?.toString() ?? '',
            unit: ingredient['unit'] ?? 'g',
          ),
        );
      }
    } else {
      // Start with one empty ingredient field
      _ingredients.add(IngredientItem());
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _addIngredient() {
    setState(() {
      _ingredients.add(IngredientItem());
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'แก้ไขเมนูอาหาร' : 'เพิ่มเมนูอาหาร',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Input
                    Text(
                      'ชื่อเมนู',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red.shade800,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'กรอกชื่อเมนูอาหาร',
                        prefixIcon: Icon(Icons.restaurant_menu, color: Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    
                    // Ingredients Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'วัตถุดิบ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red.shade800,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _addIngredient,
                          icon: Icon(Icons.add, size: 18),
                          label: Text('เพิ่มวัตถุดิบ'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    
                    // Ingredients List
                    if (_ingredients.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'กรุณาเพิ่มวัตถุดิบอย่างน้อย 1 รายการ',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _ingredients.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.red.shade100),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'วัตถุดิบที่ ${index + 1}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red.shade700,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red.shade400, size: 20),
                                        onPressed: () => _removeIngredient(index),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  
                                  // Ingredient Name
                                  TextField(
                                    controller: TextEditingController(text: _ingredients[index].name),
                                    onChanged: (val) {
                                      _ingredients[index].name = val;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'ชื่อวัตถุดิบ',
                                      prefixIcon: Icon(Icons.shopping_basket, color: Colors.red),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  
                                  // Amount and Unit
                                  Row(
                                    children: [
                                      // Amount
                                      Expanded(
                                        flex: 2,
                                        child: TextField(
                                          controller: TextEditingController(text: _ingredients[index].amount),
                                          onChanged: (val) {
                                            _ingredients[index].amount = val;
                                          },
                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          decoration: InputDecoration(
                                            hintText: 'ปริมาณ',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      
                                      // Unit dropdown
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade400),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: _ingredients[index].unit,
                                              isExpanded: true,
                                              hint: Text('หน่วย'),
                                              items: _units.map((String unit) {
                                                return DropdownMenuItem<String>(
                                                  value: unit,
                                                  child: Text(unit),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _ingredients[index].unit = newValue ?? 'g';
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
            
            // Bottom save button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('กรุณากรอกชื่อเมนูอาหาร')),
                    );
                    return;
                  }
                  
                  if (_ingredients.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('กรุณาเพิ่มวัตถุดิบอย่างน้อย 1 รายการ')),
                    );
                    return;
                  }
                  
                  // Validate all ingredients have names
                  for (int i = 0; i < _ingredients.length; i++) {
                    if (_ingredients[i].name.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('กรุณากรอกชื่อวัตถุดิบที่ ${i + 1}')),
                      );
                      return;
                    }
                  }
                  
                  // Convert to format for Firestore
                  List<Map<String, dynamic>> ingredients = _ingredients.map((i) => {
                    'name': i.name.trim(),
                    'amount': i.amount.trim().isNotEmpty ? i.amount.trim() : '',
                    'unit': i.unit,
                  }).toList();
                  
                  Navigator.pop(context, {
                    'title': _titleController.text.trim(),
                    'ingredients': ingredients,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  widget.isEditing ? 'บันทึกการแก้ไข' : 'บันทึกเมนูอาหาร',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IngredientItem {
  String name;
  String amount;
  String unit;
  
  IngredientItem({
    this.name = '',
    this.amount = '',
    this.unit = 'g',
  });
}