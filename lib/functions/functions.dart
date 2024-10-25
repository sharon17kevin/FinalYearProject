import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

Future fetchFieldData(String url) async {
  try {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load field');
    }
  } catch(error) {
    throw Exception(error);
  }
}

Future updateFieldData(String url, Map<String, dynamic>field) async {
  final headers = {'Content-Type': 'application/json'};
  final fieldBody = jsonEncode(field);
  try {
    http.Response response = await http.post(Uri.parse(url), headers: headers,
        body: fieldBody);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load field');
    }
  } catch(error) {
    throw Exception(error);
  }
}

Future fetchFieldAnalysis(String url, Map<String, dynamic>field) async {
  final headers = {'Content-Type': 'application/json'};
  final fieldBody = jsonEncode(field);
  try {
    http.Response response = await http.post(Uri.parse(url), headers: headers,
        body: fieldBody);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load field');
    }
  } catch(error) {
    throw Exception(error);
  }
}

Future fetchInitialPlan(String url, Map<String, dynamic>field) async {
  final headers = {'Content-Type': 'application/json'};
  final fieldBody = jsonEncode(field);
  try {
    http.Response response = await http.post(Uri.parse(url), headers: headers,
      body: fieldBody);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load field');
    }
  } catch(error) {
    throw Exception(error);
  }
}

fetchSinglePlan(String url, Map<String, dynamic> field, index) async {
  final headers = {'Content-Type': 'application/json'};
  final newField = {'field': field, 'index': index};
  final fieldBody = jsonEncode(newField);
  try {
    http.Response response = await http.post(Uri.parse(url), headers: headers,
        body: fieldBody);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load field');
    }
  } catch(error) {
    throw Exception(error);
  }
}