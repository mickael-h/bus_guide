import '../index.dart';

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
  goToMap() {
    Get.to(MapScreen());
  }

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
          _getCurrentLineCard(),
          _getGoToMapButton(),
          _getSetLineButton(),
        ],
      ),
    );
  }

  Widget _getSetLineButton() {
    return RaisedButton(
      child: Text('Set line number'),
      onPressed: () => Get.defaultDialog(
        title: 'New line number',
        content: TextField(
          onSubmitted: (value) {
            Get.find<PlanningController>()
                .setCurrentLine(int.tryParse(value) ?? -1);
            navigator.pop();
          },
        ),
      ),
    );
  }

  Widget _getGoToMapButton() {
    return RaisedButton(
      child: Text('Go To Map'),
      onPressed: goToMap,
    );
  }

  Widget _getCurrentLineCard() {
    return GetBuilder<PlanningController>(
      init: PlanningController(),
      builder: (_) => Card(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Current Line: ${_.currentLine}'),
          ),
        ),
      ),
    );
  }
}
