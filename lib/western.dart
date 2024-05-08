import 'package:flutter/material.dart';

class Western extends StatefulWidget {
  @override
  ParentState createState() {
    return ParentState();
  }
}

class ParentState extends State<Western> {
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
const Title = ['Hamburger Sederhana', 'Steak Daging Sirloin'];
const imagesrc = [
  'https://raw.githubusercontent.com/0xricoard/simple-recipe-app-flutter/master/assets/images/hamburger.jpg',
  'https://raw.githubusercontent.com/0xricoard/simple-recipe-app-flutter/master/assets/images/steak.jpg'
];
const Ingredients = [
  'Bahan:' +
      '\n- 1/2 kg daging sapi giling\n- 4 roti tawar\n- 1/2 bawang bombay, iris\n- 2 batang daun selada, iris tipis\n- 1/4 wortel, iris tipis\n- saus tomat secukupnya\n- saus mustard secukupnya\n- saus mayones secukupnya\n- keju parut secukupnya\n' +
      '\nCara Membuat:' +
      '\n1. Pertama-tama, bentuk daging giling menjadi 4 buah burger patties yang berukuran sama.\n2. Panaskan griddle atau wajan dengan api sedang-kecil. Kemudian panggang burger patties selama 3-4 menit per sisi, atau sampai terlihat matang. Sementara itu, panaskan roti tawar di atas griddle atau wajan yang sama selama 1-2 menit per sisi, atau sampai terlihat renyah.\n3. Setelah burger patties dan roti tawar matang, susun roti tawar di atas piring. Tuangkan saus tomat di atas roti tawar bagian bawah, kemudian tambahkan burger patty, bawang bombay, daun selada, wortel, saus mustard, dan saus mayones. Tutup dengan roti tawar bagian atas, kemudian taburi keju parut di atasnya.\n4. Sajikan hamburger sederhana yang sudah jadi bersama dengan kentang goreng atau sayuran segar sebagai pelengkap.',
  'Bahan:' +
      '\n- 250 gram daging sirloin, potong sesuai selera\n- 1 sdt garam\n- 1 sdt lada hitam\n- 1 sdt merica bubuk\n- 1 sdt paprika bubuk\n- 2 sdm minyak sayur\n- 1 sdt unsalted butter\n' +
      '\nCara Membuat:' +
      '\n1. Campur garam, lada hitam, merica bubuk, dan paprika bubuk dalam sebuah wadah kecil. Kemudian usapkan campuran tersebut ke seluruh permukaan daging sirloin,\n2. Panaskan minyak sayur di dalam wajan atau skillet dengan api sedang-tinggi. Kemudian masukkan daging sirloin ke dalam wajan, lalu panggang selama 3-4 menit per sisi, atau sampai terlihat matang sesuai selera. Setelah matang, angkat daging sirloin dari wajan dan sisihkan.\n3. Tambahkan butter ke dalam wajan yang sama, lalu tambahkan bawang bombay dan bawang putih yang sudah diiris tipis-tipis. Tumis selama 2-3 menit, atau sampai bawang bombay dan bawang putih terlihat layu. Kemudian tambahkan saus tiram dan saus Worcestershire ke dalam wajan, lalu aduk rata.\n4. Kemudian masukkan kembali daging sirloin ke dalam wajan, lalu tambahkan juga irisan daun bawang dan seledri ke dalam saus. Aduk rata, lalu masak selama 1-2 menit, atau sampai saus mengental dan daging sirloin terlihat empuk.\n5. Angkat daging sirloin dari wajan, lalu sajikan bersama dengan nasi putih atau bahan pelengkap lainnya sesuai selera.'
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
