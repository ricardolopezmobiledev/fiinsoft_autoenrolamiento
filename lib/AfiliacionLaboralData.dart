import 'package:flutter/material.dart';
import 'DatosLaborales.dart';
class LaboralData extends StatefulWidget {
  const LaboralData({Key key}) : super(key: key);

  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<LaboralData> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Solicitud',
              ),
              Tab(
                text: 'Digitalización',
              ),
              Tab(
                text: 'Notas',
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text('Afiliación'),
        ),
        body: TabBarView(
          children: [
            ContactLaboralData (),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

