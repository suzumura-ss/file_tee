#
#   Copyright 2010 Toshiyuki Terashita.
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
#   along with Castoro.  If not, see <http://www.gnu.org/licenses/>.
#
require 'fileutils'
require 'lib/file_tee'

TEMPDIR = `mktemp -d`.strip
Kernel.at_exit{ FileUtils.rm_rf(TEMPDIR) }

describe FileTee do
  context "write to 2 files" do
    before do
      @path_to_read  = __FILE__
      @path_to_write1 = File.join(TEMPDIR, "write1")
      @path_to_write2 = File.join(TEMPDIR, "write2")
    end

    it "should be success to write with File-object" do
      File.open(@path_to_read, "r") {|rf|
        File.open(@path_to_write1, "w") {|w1|
          File.open(@path_to_write2, "w") {|w2|
            FileTee.open(rf, w1) {|tee|
              while data = tee.read(1024)
                w2.write(data)
              end
            }
          }
        }
      }
      IO.read(@path_to_read).should == IO.read(@path_to_write1)
      IO.read(@path_to_read).should == IO.read(@path_to_write2)
    end

    it "should be success to write with file-name" do
      File.open(@path_to_write2, "w") {|w2|
        FileTee.open(@path_to_read, @path_to_write1) {|tee|
          while data = tee.read(1024)
            w2.write(data)
          end
        }
      }
      IO.read(@path_to_read).should == IO.read(@path_to_write1)
      IO.read(@path_to_read).should == IO.read(@path_to_write2)
    end

    after do
      FileUtils.rm_f(@path_to_write1)
      FileUtils.rm_f(@path_to_write2)
    end
  end
end
