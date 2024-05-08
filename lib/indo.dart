import 'package:flutter/material.dart';

class Indo extends StatefulWidget {
  @override
  ParentState createState() {
    return ParentState();
  }
}

class ParentState extends State<Indo> {
  void Increment() {
    setState(() {
      if (IndeksResep >= Ingredients.length - 1)
        IndeksResep = 0;
      else
        IndeksResep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Resepku',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Resepku App'),
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white,
            ),
          ),
          //widget kolom
          body: Recipe(),
          floatingActionButton: Container(
            height: 50,
            width: 100,
            child: FloatingActionButton.extended(
              onPressed: () {
                Increment();
              },
              label: Text('Next', style: TextStyle(fontSize: 18)),
              icon: Icon(Icons.navigate_next),
              backgroundColor: Colors.blue,
            ),
          ),
        ));
  }
}

//Data Array Resep
const Title = ['Nasi Goreng Sederhana', 'Bakmi Goreng Kampung'];
const imagesrc = [
  'https://raw.githubusercontent.com/0xricoard/simple-recipe-app-flutter/master/assets/images/nasgor.jpg',
  'https://raw.githubusercontent.com/0xricoard/simple-recipe-app-flutter/master/assets/images/bakmi.jpeg',
];
const Ingredients = [
  'Bahan:' +
      '\n-4 sdm minyak goreng \n-2 batang daun bawang \n-150 g wortel \n-iris dadu kecil' +
      '\n-600 g nasi dingin, \n-1 sdt merica putih bubuk, \n-2 sdm kecap asin, \n-4 butir telur ayam, kocok lepas, \n-1 sdm minyak wijen.' +
      '\nCara Membuat:' +
      '\n1. Panaskan minyak goreng di wajan. Tumis daun bawang hingga harum. Tambahkan wortel dan tumis sebentar.\n2. Tambahkan nasi dingin, merica putih, dan kecap asin. Aduk rata.\n3. Tambahkan telur yang sudah dikocok lepas. Aduk hingga tercampur rata.\n4. Angkat dan sajikan. Bisa ditaburi dengan minyak wijen di atasnya jika suka.\n',
  'Bahan:' +
      '\n-140 gram mi telur, \n-1 buah wortel, \n-1/4 buah kol potong-potong' +
      '\n-1 batang daun bawang diiris, \n-1 batang seledri diiris, \n-5 siung bawang merah, \n-3 siung bawang putih, \n-3 buah cabai rawit, \n-kecap manis, garam, dan kaldu jamur secukupnya, \n-bawang goreng sebagai taburan.' +
      '\nCara Membuat:' +
      '\n1. Rebus mi telur sampai setengah matang. Angkat dan tiriskan.\n2. Haluskan bawang merah, bawang putih, dan merica.\n3. Panaskan sedikit minyak. Tumis bumbu halus. Masukkan wortel, kol, daun bawang, dan seledri. Aduk rata. Masukkan cabai rawit.\n4. Masukkan mi. Tambahkan garam, kaldu jamur, dan kecap manis. Aduk rata. Koreksi rasa.\n5. Masak hingga bumbu meresap. Angkat dan sajikan dengan bawang goreng.\n'
];
// Akhir data Array Resep

int IndeksResep = 0;

class Recipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.black12,
              width: double.infinity,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    Title[IndeksResep],
                    //textScaleFactor: 1,
                    style: (TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.5))),
                    textAlign: TextAlign.center,
                  ))),
        ),
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            child: Image.network(imagesrc[IndeksResep], fit: BoxFit.fill),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.black12,
            child: SingleChildScrollView(
              child: Text(Ingredients[IndeksResep],
                  style: (TextStyle(fontSize: 19)),
                  textAlign: TextAlign.justify),
            ),
          ),
        )
      ],
    );
  }
}
