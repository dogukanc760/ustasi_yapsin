import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ustasi_yapsin/models/category.dart';
import 'package:ustasi_yapsin/screens/hizmetkarsilama.dart';

List<Category> categoryListe = [];
class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  var isLoading = false;
  Future<List<Category>> veriAl() async {
    categoryListe.clear();
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse('https://ustasiyapsin-api.herokuapp.com/api/category'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      //  print(result['data'][0]['_id'])
      setState(() {
        for (var i = 0; i < result['data'].length; i++) {
          print(result['data'][i]);

          categoryListe.add(Category(
              name: result['data'][i]['name'],
              img: result['data'][i]['img'],
              isActive: result['data'][i]['isActive'],
              showHome: result['data'][i]['showHome'],
              id: result['data'][i]['_id']));
          print(categoryListe[i].name);
        }
      });
      setState(() {
        isLoading = false;
      });
      return categoryListe;
    } else {
      throw Exception();
    }
  }
  @override
  void initState() {
    categoryListe.clear();
    veriAl();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isLoading
            ? Padding(
          padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
          child: Center(child: CircularProgressIndicator()),
        )
            : Column(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color: Colors.white, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 0.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color: Colors.white, width: 0.0),
                            ),
                            contentPadding:
                            new EdgeInsets.symmetric(vertical: 0),
                            hintText: 'Kategoriler',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            filled: true,
                            suffixIcon: IconButton(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 12.0),
                              alignment: Alignment.centerLeft,
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                              ),
                            )),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Boş Bir Sorgu Aranamaz!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 25,
                  endIndent: 55,
                ),
              ],
            ),
            Column(
              children: [
                Row(children: [
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: categoryListe.length,
                          itemBuilder:
                              (BuildContext context, int index) => Row(
                            children: [
                              Card(
                                elevation: 0,
                                child: Center(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 15),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(top: 5),
                                        child: Row(
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      90.0),
                                                  side: BorderSide(
                                                      width: 2.3,
                                                      color: Colors
                                                          .purpleAccent)),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(3.0),
                                                child: Image.network(
                                                  'https://ustasiyapsin-api.herokuapp.com/images/' +
                                                      categoryListe[index]
                                                          .img,
                                                  height: 35,
                                                  width: 35,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  20, 0, 0, 0),
                                              child: Text(
                                                categoryListe[index].name,
                                                style:
                                                TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HizmetKarsilama(
                                                                categoryId:
                                                                categoryListe[
                                                                index]
                                                                    .id,
                                                                categoryName:
                                                                categoryListe[
                                                                index]
                                                                    .name,
                                                                categoryImg:
                                                                categoryListe[
                                                                index]
                                                                    .img,
                                                              )));
                                                },
                                                icon: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                ))
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ));
  }

}
