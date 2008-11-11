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
namespace Anvil {
  public static HashTable<GLib.Type, GLib.Type> handlers;
  public static HashTable<string, GLib.Type> backends;
  public static bool is_initialized = false;
}