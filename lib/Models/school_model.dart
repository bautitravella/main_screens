
class School {
  int id;
  String imageUrl;
  String name;




  School({
    this.id,
    this.imageUrl,
    this.name,

  });
}


List<School> schools = [

  School(
    id: 1,
    imageUrl: 'assets/images/logocolegio-fds.png',
    name: 'Florida Day School',
  ),
  School(
    id: 2,
    imageUrl: 'assets/images/logocolegio-ntl.png',
    name: 'Northlands',
  ),
  School(
    id: 3,
    imageUrl: 'assets/images/logocolegio-gosho.png',
    name: 'San Gregorio',

  ),
];
