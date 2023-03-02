Here is an example:

```
void main(List<String> args) async {
  JtPreferences.initialize("store path");
  final args = JtPreferences.getInstance();
  await args.setString('token', '123');
  await args.setInt('age', 18);
  await args.setDouble('weight', 18.5);
  await args.setBool('isFree', false);

  args.listen(key: 'token').listen((event) {
    print("key $event updated");
  });

  args.listen().listen((event) {
    print("key $event updated");
  });
}

```

[Open pub.dev](https://pub.dev/packages/jt_preferences)
