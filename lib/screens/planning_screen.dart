import 'package:bus_guide/index.dart';

class PlanningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Planning'),
      ),
      body: PlanningListView(),
    );
  }
}

class PlanningListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(
            const Duration(seconds: 1)); // TODO: actually refresh list
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          _getGoToMapButton(),
        ],
      ),
    );
  }

  Widget _getGoToMapButton() {
    return RaisedButton(
      child: Text('Go To Map'),
      onPressed: goToMap,
    );
  }

  goToMap() {
    Get.to(MapScreen());
  }
}
