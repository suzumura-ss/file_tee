#
#   Copyright 2010 Toshiyuki Suzumura.
#
#   This file is part of file_tee.
#
#   This is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Lesser General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This software is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public License
#   along with this software.  If not, see <http://www.gnu.org/licenses/>.
#

class FileTee
  def self.open(r_file, w_file)
    raise ArgumentError, "No block given." unless block_given?
    rf = (r_file.respond_to?(:read)) ? r_file : File.open(r_file)
    wf = (w_file.respond_to?(:write_nonblock)) ? w_file : File.open(w_file, "w")
    yield FileTee.new(rf, wf)
  ensure
    rf.close if !r_file.respond_to?(:read) and !rf.nil?
    wf.close if !w_file.respond_to?(:write_nonblock) and !wf.nil?
  end

  def read(bytes)
    data = @rf.read(bytes)
    @wf.write_nonblock(data)
    data
  end

private
  def initialize(rf, wf)
    @rf = rf
    @wf = wf
  end
end
