part of '../dao_service.dart';
class Command {
  static final String READS = 'select * from employees';
  static final String READ = 'select * from employees where eid = :eid';
  static final String DELETE = 'delete from employees where eid = :eid';
  static final String UPDATE = 'update employees set firstname = :firstname , lastname = :lastname , position = :position , active = :active , salary = :salary  where eid = :eid';
  static final String CREATE = 'insert into employees values(:eid,:firstname,:lastname,:position,:active,:salary)';
}