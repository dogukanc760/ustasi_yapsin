import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/screens_service_provider/anasayfa_hv.dart';


class TalepKabul extends StatelessWidget {
  const TalepKabul({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: SingleChildScrollView(
              child: Stack(
                children: [KabulDetay()],
              )),
        ),

      ),
    );
  }
}


class KabulDetay extends StatefulWidget {
  const KabulDetay({Key? key}) : super(key: key);

  @override
  _KabulDetayState createState() => _KabulDetayState();
}

class _KabulDetayState extends State<KabulDetay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
             padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
             child: Text('Vermiş olduğunuz bilgiler hizmet veren ile'
                 '  anlaşıldığı takdirde hizmet veren tarafından görüntülenecektir.',
               style: TextStyle(color:Colors.grey.shade500, fontSize: 20),textAlign: TextAlign.center,),
           ),
           SizedBox(
             width: 250,
             height:250,
             child: Image.asset('assets/resim_ikon.png')
           ),
          FlatButton(onPressed: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) =>
                        AnasayfaHizmet()
                )
            );
          },
              minWidth: 170,
              color:Colors.deepPurple,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Text('Adresime Gelsin', style: TextStyle(color:Colors.white),)),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Column(
              children: [
                Icon(Icons.location_on_outlined, color: Colors.blue, size: 40,),
                FlatButton(onPressed: (){},
                    minWidth: 170,
                    color:Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.deepPurple)
                    ),
                    child: Text('Konuma Gelsin', style: TextStyle(color:Colors.deepPurple),)),
              ],
            ),
          )
        ],
      )
    );
  }
}
