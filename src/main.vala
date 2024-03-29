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
using Anvil;

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
      return "%s %s".printf(this.name, this.surname);
    }
  }

  construct {
    this.name = "John";
    this.surname = "Doe";
    this.age = 33;
  }

}

public class IntrospectionData : GLib.Object {

  public GLib.ParamSpec[] properties {
    get  {
      return this.klass.list_properties();
    }
  }
  public GLib.ObjectClass #klass  {
    get {
      return (ObjectClass)this.typ.class_ref();
    }
  }
  public GLib.Type typ {get;construct set;}

  public IntrospectionData (GLib.Object obj) {
    this.typ = obj.get_type();
  }

}

public class Main {

  static int main (string[] args) {
    Anvil.anvil_init();
    Person person = new Person();
    IntHandler sh1 = new IntHandler ();
    ObjectHandler oh1 = new ObjectHandler ();
    IntrospectionData id1 = new IntrospectionData((GLib.Object) person);
    IntrospectionData id2 = new IntrospectionData((GLib.Object) sh1);
    string fname = person.fullname;
    register_handler(person.get_type(), typeof(ObjectHandler));
    GLib.print("Person name: %s\n\n", fname);
    GLib.print("Instrospecting...\n");
    GLib.print(" >>> Type name: %s\n", id1.typ.qname().to_string());
    GLib.print(" Properties:\n");
    foreach (GLib.ParamSpec param in id1.properties) {
      GLib.print(" >>>>>> %s of type: %s\n", param.get_blurb(), param.value_type.qname().to_string());
    }
    GLib.print("\n");
    ObjectHandler oh2 = ((ObjectHandler) get_handler(person.get_type()));

    fname = id2.typ.qname().to_string();
    GLib.print("Class name: %s\n\n", fname);
    GLib.print("Instrospecting...\n");
    GLib.print(" >>> Type name: %s\n", id2.typ.qname().to_string());
    GLib.print(" Properties:\n");
    foreach (GLib.ParamSpec param in id2.properties) {
      GLib.print(" >>>>>> %s of type: %s\n", param.name, param.value_type.qname().to_string());
    }
    GLib.print("\n");

    return 0;
  }
}