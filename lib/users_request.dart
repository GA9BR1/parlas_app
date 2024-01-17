import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Person>> getPeople() async {
  var url = Uri.parse("https://randomuser.me/api/?results=5");
  try {
    var response = await http.get(url);

    return peopleFromJson(response.body);
  } catch (e) {
    return [];
  }
}

List<Person> peopleFromJson(String str) {
  final jsonData = json.decode(str);
  final results = jsonData['results'];
  List<Person> people = [];
  for (var result in results) {
    people.add(Person.fromJson(result));
  }
  return people;
}

class Person {
  late String gender;
  late Name name;
  late Location location;
  late String email;
  late Dob dob;
  late String cell;
  late Picture picture;
  bool isLiked = false;

  Person({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.dob,
    required this.cell,
    required this.picture,
  });

  factory Person.fromJson(Map<String, dynamic> result) {
    return Person(
      gender: result['gender'],
      name: Name.fromJson(result['name']),
      location: Location.fromJson(result['location']),
      email: result['email'],
      dob: Dob.fromJson(result['dob']),
      cell: result['cell'],
      picture: Picture.fromJson(result['picture']),
    );
  }
}

class Name {
  late String title;
  late String first;
  late String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> name) {
    return Name(
      title: name['title'],
      first: name['first'],
      last: name['last'],
    );
  }
}

class Dob {
  late String date;
  late int age;

  Dob({
    required this.date,
    required this.age,
  });

  factory Dob.fromJson(Map<String, dynamic> dob) {
    return Dob(
      date: dob['date'],
      age: dob['age'],
    );
  }
}

class Picture {
  late String large;
  late String medium;
  late String thumbnail;

  Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory Picture.fromJson(Map<String, dynamic> picture) {
    return Picture(
      large: picture['large'],
      medium: picture['medium'],
      thumbnail: picture['thumbnail'],
    );
  }
}

class Location {
  late Street street;
  late String city;
  late String state;
  late String country;
  late String postcode;

  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
  });

  factory Location.fromJson(Map<String, dynamic> location) {
    return Location(
      street: Street.fromJson(location['street']),
      city: location['city'],
      state: location['state'],
      country: location['country'],
      postcode: location['postcode'].toString(),
    );
  }
}

class Street {
  late int number;
  late String name;

  Street({
    required this.number,
    required this.name,
  });

  factory Street.fromJson(Map<String, dynamic> street) {
    return Street(
      number: street['number'],
      name: street['name'],
    );
  }
}
