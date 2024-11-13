import 'package:apicats/service/cats_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class home_page_cats extends StatefulWidget {
  const home_page_cats({super.key});

  @override
  State<home_page_cats> createState() => _home_page_catsState();
}

class _home_page_catsState extends State<home_page_cats> {
  String raca = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void alert() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Information"),
        content: const Text(
            "The characteristic below are classified as the following: \n 1-Low\n 2-Sightly Lower\n 3-Average\n 4-Sightly High\n 5-High "),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://i.pinimg.com/564x/8c/43/db/8c43dbd2d46c6091705400fca12bd2ab.jpg',
                fit: BoxFit.contain,
                height: 80,
              ),
              Expanded(
                  child: Image.network(
                'https://i.pinimg.com/564x/8c/0f/2f/8c0f2f9fdd0d038667022416f2082669.jpg',
                fit: BoxFit.contain,
                height: 70,
              )),
              Expanded(
                child: Image.network(
                  'https://i.pinimg.com/564x/7b/a7/5f/7ba75f191d6f601826c35a54194afbaf.jpg',
                  fit: BoxFit.contain,
                  height: 90,
                ),
              ),

              Expanded(
                child: Image.network(
                  'https://i.pinimg.com/originals/33/7a/c3/337ac34ee897d5d30be4a9d759a4b0ac.gif',
                  fit: BoxFit.contain,
                  height: 90,
                ),
              )
              // Alinha a imagem à esquerda
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 100, // Alinhada ao topo da tela
              left: 0, // Alinhada à esquerda da tela
              right: 0, // Alinhada à direita da tela
              bottom: 100,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/imgs/patas.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(
                            0.5), // Define a transparência da imagem
                        BlendMode.dstATop),
                  ),

                  color: Colors.white, // Cor de fundo
                  borderRadius:
                      BorderRadius.circular(20), // Cantos arredondados
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.grey.withOpacity(0.3), // Sombra com opacidade
                      spreadRadius: 5, // Difusão da sombra
                      blurRadius: 10, // Desfoque da sombra
                      offset:
                          Offset(0, 10), // Deslocamento horizontal e vertical
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 208, 221, 232),
                      Color.fromARGB(255, 176, 176, 176)
                    ], // Gradiente de cores
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Digite: ",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    onSubmitted: (value) {
                      setState(
                        () {
                          raca = value;
                        },
                      );
                    },
                  ),
                  /* Expanded(
                      child: Image.network(
                    'https://i.pinimg.com/originals/1e/4f/0e/1e4f0eb0885c18f96a847304259bde45.gif',
                    fit: BoxFit.contain,
                    height: 90,
                  )),*/
                  Expanded(
                    child: FutureBuilder(
                      future: raca != "" ? fatosGatos(raca) : null,
                      builder: ((context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                              width: 200.0,
                              height: 200.0,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 5.0,
                              ),
                            );
                          case ConnectionState.none:
                            return Container();
                          default:
                            // print(snapshot);
                            if (snapshot.hasError || snapshot.data!.isEmpty) {
                              return SizedBox(
                                  // width: 70,
                                  // height: 50,
                                  child: Container(
                                padding: const EdgeInsets.all(20.0),
                                alignment: Alignment.center,
                                /*   decoration: const BoxDecoration(
                                      color: Colors.blue,
                                    ),*/
                                child: const Text("Not Found",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 17, 17, 17),
                                      fontStyle: FontStyle.normal,
                                      fontSize: 18.0,
                                      backgroundColor:
                                          Color.fromARGB(255, 231, 231, 231),
                                    )),
                              ));
                            } else if (snapshot.hasData &&
                                snapshot.data!.isNotEmpty) {
                              return resultado(context, snapshot);
                            } else {
                              return Container();
                            }
                        }
                      }),
                    ),
                  ),
                ],
                /*  */
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultado(BuildContext context, AsyncSnapshot snapshot) {
    //List<Widget> elements = [];

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20), //
            child: Image.network(
              snapshot.data[0]['image_link'],
              fit: BoxFit.contain,
              height: 200,
            ),
          ),
          Row(
            children: [
              Container(
                width: 300,
                height: 1000,
                margin: EdgeInsets.only(top: 20, left: 50, bottom: 20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 193, 193, 193),
                  border: Border.all(
                    color: Color.fromARGB(255, 59, 62, 63), // Cor da borda
                    width: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3)),
                  ],
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 217, 217, 217),
                      Color.fromARGB(255, 182, 181, 181)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data[0]['name'],
                      style: const TextStyle(
                        fontSize: 18.0,
                        //  fontFamily: 'Open Sans',
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Arial',
                        color: Color.fromARGB(255, 17, 16, 16),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Origin",
                      style: TextStyle(
                        color: Color.fromARGB(255, 17, 16, 16),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      snapshot.data[0]['origin'],
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Arial'),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Max Life Expectancy",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      snapshot.data[0]['max_life_expectancy'] != null
                          ? NumberFormat()
                              .format(snapshot.data[0]['max_life_expectancy'])
                          : 'atributo não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontFamily: 'Open Sans',
                          fontSize: 18.0),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Min Life Expectancy",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data[0]['min_life_expectancy'] != null
                          ? NumberFormat()
                              .format(snapshot.data[0]['min_life_expectancy'])
                          : 'atributo não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Max Weight",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      snapshot.data[0]['max_weight'] != null
                          ? NumberFormat()
                              .format(snapshot.data[0]['max_weight'])
                          : 'atributo não econtrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic),
                    ),
                    const Text(
                      "Min Weight",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data[0]['min_weight'] != null
                          ? NumberFormat()
                              .format(snapshot.data[0]['min_weight'])
                          : 'atributo não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Other Pets Friendly",
                            style: TextStyle(
                                color: Color.fromARGB(255, 17, 16, 16),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            child: Icon(Icons.info),
                            onTap: () {
                              return alert();
                            },
                          )
                        ]),
                    Text(
                      snapshot.data[0]['other_pets_friendly'] != null
                          ? NumberFormat()
                              .format(snapshot.data[0]['other_pets_friendly'])
                          : 'atributo não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 9, 7, 7),
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Intelligence",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      // '${snapshot.data[0]['intelligence']}',
                      snapshot.data[0]['intelligence'] != null
                          ? NumberFormat()
                              .format(snapshot.data[0]['intelligence'])
                          : 'atributo não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic),
                    ),
                    const Text(
                      "Grooming",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data[0]['grooming'] != null
                          ? NumberFormat().format(snapshot.data[0]['grooming'])
                          : 'atribito não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic),
                    ),
                    const Text(
                      "Children Friendly",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data[0]['children_friendly'] != null
                          ? NumberFormat()
                              .format(snapshot.data[0]['children_friendly'])
                          : 'atributo não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 5),
                    const Text(
                      "Playfulness",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data[0]['playfulness'] != null
                          ? NumberFormat()
                              .format(snapshot.data[0]['playfulness'])
                          : 'atributo não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 5),
                    const Text(
                      "General Health",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data[0]['general_health'] != null
                          ? NumberFormat()
                              .format(snapshot.data[0]['general_health'])
                          : 'atributo não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic),
                    ),
                    const Text(
                      "Shedding",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data[0]['shedding'] != null
                          ? NumberFormat().format(snapshot.data[0]['shedding'])
                          : 'atributo não encontrado',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 5),
                    const Text(
                      "Family Friendly",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data[0]['family_friendly'] != null
                          ? NumberFormat()
                              .format(snapshot.data[0]['family_friendly'])
                          : 'atributo não nulo',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Length",
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 16, 16),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (snapshot.data[0]['length']),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 17, 16, 16),
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /*  TextField(
            enabled: false,
            decoration: InputDecoration(
              labelText: snapshot.data[0]['name'],
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),*/
        ],
      ),
    );
  }
}

/*for (int i = 0; i < snapshot.data.length; i++) {
      print("i = $i, name = ${snapshot.data[i]["name"]}");
      elements.add(TextField(
        decoration: InputDecoration(
            labelText: snapshot.data[i]["name"],
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder()),
        style: TextStyle(color: Colors.white, fontSize: 18),
      ));
    }*/
