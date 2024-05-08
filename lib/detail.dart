import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'recipe_card.dart';

class Detail extends StatefulWidget {
  final int recipeId;

  Detail({required this.recipeId});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<Map<String, dynamic>> recipeFuture;

  @override
  void initState() {
    super.initState();
    recipeFuture = fetchRecipeDetail(widget.recipeId);
  }

  Future<Map<String, dynamic>> fetchRecipeDetail(int recipeId) async {
    final response = await http.get(
        Uri.parse('http://192.168.100.87:8000/api/drink-recipes/$recipeId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: recipeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final recipe = snapshot.data!['recipe'];
          final resepRecommendation = snapshot.data!['resepRecommendation'];

          return Scaffold(
            appBar: AppBar(
              title: Text('Resep Minuman'),
              leading: BackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildRecipeTitle(recipe['name']),
                  _buildRecipeDetails(recipe['ingredient'], recipe['step']),
                  if (resepRecommendation is Map<String, dynamic> &&
                      resepRecommendation.isNotEmpty)
                    _buildRecommendations(resepRecommendation),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildRecipeTitle(String title) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRecipeDetails(String ingredients, String steps) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bahan-bahan:',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.5)),
          ),
          SizedBox(height: 10),
          Text(
            ingredients.split(', ').map((item) => '- $item\n').join(),
            style:
                TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.7)),
          ),
          SizedBox(height: 20),
          Text(
            'Cara Membuat:',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.5)),
          ),
          SizedBox(height: 10),
          Text(
            steps,
            style:
                TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations(Map<String, dynamic> recommendations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Resep Rekomendasi:',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.5)),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendations.length,
            itemBuilder: (context, index) {
              final recommendation = recommendations.values.elementAt(index);
              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Detail(recipeId: recommendation['id']),
                    ),
                  );
                },
                child: RecipeCard(
                  title: recommendation['name'],
                  purchaseLink: recommendation['purchase_link'],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
