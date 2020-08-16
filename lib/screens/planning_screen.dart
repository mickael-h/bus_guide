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
  final UserController _userController = Get.find<UserController>();
  final PlanningController _planningController = Get.find<PlanningController>();

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
          _getUserCard(),
          _getCurrentLineCard(),
          _getGoToMapButton(),
          _getSetLineButton(),
          _getChangeUserDataButton(),
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
            _planningController.setCurrentLine(int.tryParse(value) ?? -1);
            navigator.pop();
          },
        ),
      ),
    );
  }

  Widget _getChangeUserDataButton() {
    return RaisedButton(
      child: Text('Change User Data'),
      onPressed: changeUserData,
    );
  }

  changeUserData() {
    Get.defaultDialog(
      title: 'Change User Data',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NamedTextField(
              name: 'ID: ',
              onChanged: (value) => _userController.updateId(value)),
          NamedTextField(
              name: 'Name: ',
              onChanged: (value) => _userController.updateName(value)),
          NamedTextField(
              name: 'Email: ',
              onChanged: (value) => _userController.updateEmail(value)),
          NamedTextField(
              name: 'Favorite Line: ',
              onChanged: (value) =>
                  _userController.updateFavoriteLine(int.parse(value) ?? -1)),
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

  Widget _getUserCard() {
    return Obx(() {
      User val = _userController.user.value;
      return ListCard(
        child: Text(
            'User Data: ${val.id}, ${val.name}, ${val.email}, ${val.favoriteLine}'),
      );
    });
  }

  Widget _getCurrentLineCard() {
    return Obx(() {
      return ListCard(
        child: Text('Current Line: ${_planningController.currentLine.value}'),
      );
    });
  }
}

class NamedTextField extends StatelessWidget {
  const NamedTextField({Key key, this.onChanged, this.name}) : super(key: key);
  final Function onChanged;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(flex: 0, child: Text(name)),
        Expanded(flex: 1, child: TextField(onChanged: onChanged)),
      ],
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: child,
        ),
      ),
    );
  }
}
