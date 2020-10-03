import 'package:bus_guide/index.dart';

class PlanningListEntry extends StatelessWidget {
  final String text;
  final void Function() onTap;
  PlanningListEntry({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        title: Text(text),
        onTap: onTap,
      ),
    );
  }
}
