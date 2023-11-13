
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// get third party package, store the function it provides in a variable
import 'package:uuid/uuid.dart';
const uuid = Uuid();

final formatter = DateFormat.yMd();

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.travel_explore,
  Category.leisure: Icons.free_breakfast,
  Category.work: Icons.work
};

enum Category {
  food,
  travel,
  leisure,
  work
}

class Expense{
  Expense({
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category
    }) 
    // now we use an initializer list to define the "id", so it's created dynamically when the object is created
    // we call the v4 function of Uuid() to create a unique id
    : id = uuid.v4(); 

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}