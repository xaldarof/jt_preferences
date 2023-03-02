Here is an example:

```
void main(List<String> args) async {
  final args = JtPreferences.getInstance();
  await args.setString('token', '123');
  await args.setInt('age', 18);
  await args.setDouble('weight', 18.5);
  await args.setBool('isFree', false);

  //listen single key
  args.listen(key: 'token').listen((event) {
    print("key $event updated");
  });

  //listen all changes
  args.listen().listen((event) {
    print("key $event updated");
  });
}

```

[Open pub.dev](https://pub.dev/packages/jt_preferences)
