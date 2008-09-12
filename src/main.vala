/* main.vala
 *
 * Copyright (C) 2008  Gabriel Falcão
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Author:
 * 	Gabriel Falcão <gabriel@nacaolivre.org>
 */

using GLib;
using Vala;

public class Person : GLib.Object {

  [Description(nick="My age", blurb="The age of mine!")]
  public int age {get;set;}

  [Description(nick="My name", blurb="The name of mine!")]
  public string name {get;set;}

  [Description(nick="My surname", blurb="The surname of mine!")]
  public string surname {get;set;}

  [Description(nick="My fullname", blurb="A Dynamically represented fullname")]
  public string #fullname {
    get {
      return "Person: %s %s".printf(this.name, this.surname);
    }
  }

  construct {
    this.name = "John";
    this.surname = "Doe";
    this.age = 33;
  }

}

public class Main : GLib.Object {


  static int main (string[] args) {
    Main main = new Main ();
    Person person = new Person();
    Type typ = person.get_type();
    ObjectClass cls = (ObjectClass)typ.class_ref();
    string classname = typ.qname().to_string();
    print("Introspecting...\n");
    print(" >>> Class name: %s\n", classname);
    print(" >>> Listing properties of %s...\n", classname);
    foreach (GLib.ParamSpec prp in cls.list_properties()) {
      print(" >>>>>> Property name: %s\n" , prp.name);
    }
    string fname = person.fullname;
    print("Person name: %s\n\n", fname);

    return 0;
  }

}
