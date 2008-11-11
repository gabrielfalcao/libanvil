/* core.vala
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
using Vala;
using Gee;

namespace Anvil {
  public static void register_handler(GLib.Type type, GLib.Type handler) {
    if (Anvil.handlers == null)
      Anvil.handlers = new HashTable<GLib.Type, GLib.Type> (int_hash, int_equal);

    Anvil.handlers.replace(type, handler);

  }
  public static void register_backend(string backend, GLib.Type handler) {
    if (Anvil.backends == null)
      Anvil.backends = new HashTable<GLib.Type, GLib.Type> (str_hash, str_equal);

    Anvil.backends.replace(backend, handler);
  }
  public static GLib.Object get_handler(GLib.Type type) {
    GLib.Type ntyp = Anvil.handlers.lookup(type);

    if (ntyp != 0)
      return GLib.Object.new(ntyp);
    else
      return new NullHandler ();
  }

  public static bool anvil_init() {
    if (Anvil.is_initialized)
      return false;

    IntHandler hi = new IntHandler();hi.unref();
    StringHandler hs = new StringHandler(); hs.unref();
    UintHandler hu = new UintHandler(); hu.unref();
    ObjectHandler ho = new ObjectHandler(); ho.unref();
    HashTableHandler hh = new HashTableHandler(); hh.unref();
    NullHandler hn = new NullHandler(); hn.unref();




    Anvil.register_handler(typeof (int), typeof (IntHandler));
    Anvil.register_handler(typeof (string), typeof (StringHandler));
    Anvil.register_handler(typeof (uint), typeof (UintHandler));
    Anvil.register_handler(typeof (GLib.Object), typeof (ObjectHandler));
    Anvil.register_handler(typeof (GLib.HashTable), typeof (HashTableHandler));
    Anvil.register_handler(0, typeof (NullHandler));
    Anvil.is_initialized = true;
    return true;
  }
}