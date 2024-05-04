class Employee {
  String _eid;
  String _firstname;
  String _lastname;
  String _position;
  bool _active;
  double _salary;

  Employee(this._eid, this._firstname, this._lastname, this._position, this._active, this._salary);

  double get salary => _salary;

  set salary(double value) {
    _salary = value;
  }

  bool get active => _active;

  set active(bool value) {
    _active = value;
  }

  String get position => _position;

  set position(String value) {
    _position = value;
  }

  String get lastname => _lastname;

  set lastname(String value) {
    _lastname = value;
  }

  String get firstname => _firstname;

  set firstname(String value) {
    _firstname = value;
  }

  String get eid => _eid;

  set eid(String value) {
    _eid = value;
  }


  /**
      ****************************************************************************
      In dart you have to know about response object to be json                  *
      it can't response                                                          *
      This package (import 'dart:convert') save data by JSON encoded,            *
      and The jsonEncode can't convert the object.                               *
      We need to create the function in the class for JSON conversion.           *
      ****************************************************************************
   */
  Map<String, dynamic> toJson() {
    return {
      'eid': _eid,
      'firstname': _firstname,
      'lastname': _lastname,
      'position': _position,
      'active': _active,
      'salary': _salary,
    };
  }

  @override
  String toString() {
    return 'Employee{_eid: $_eid, _firstname: $_firstname, _lastname: $_lastname, _position: $_position, _active: $_active, _salary: $_salary}';
  }

}