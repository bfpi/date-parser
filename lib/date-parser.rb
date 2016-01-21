#--
# Copyright (c) 2016 BFPI - Büro für praktische Informatik GmbH
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#++

require 'date'

module AddParserToDate
  def new(*args)
    return super unless args.length == 1 && args[0].class.eql?(String)

    dat = args[0]
    dat.strip! if dat.respond_to?(:strip!)
    begin
      if dat =~ /^([0]?[1-9]|[12][0-9]|3[01])\.([0]?[1-9]|[1][0-2])\.[0-9]{2}$/
        Date.strptime(dat, "%d.%m.%y")
      elsif dat =~ /^([0]?[1-9]|[12][0-9]|3[01])\.([0]?[1-9]|[1][0-2])\.[0-9]{4}$/
        Date.strptime(dat, "%d.%m.%Y")
      elsif dat =~ /^[0-9]{6}$/
        Date.strptime("#{dat[0..1]}.#{dat[2..3]}.#{dat[4..5]}", "%d.%m.%y")
      elsif dat =~ /^[0-9]{8}$/
        Date.strptime("#{dat[0..1]}.#{dat[2..3]}.#{dat[4..7]}", "%d.%m.%Y")
      elsif dat =~ /^[0-9]{2}-([0]?[1-9]|[1][0-2])-([0]?[1-9]|[12][0-9]|3[01])$/
        Date.strptime(dat, "%y-%m-%d")
      elsif dat =~ /^[0-9]{4}-([0]?[1-9]|[1][0-2])-([0]?[1-9]|[12][0-9]|3[01])$/
        Date.strptime(dat, "%Y-%m-%d")
      else
        nil
      end
    rescue ArgumentError
      nil
    end
  end
end

Date.singleton_class.prepend AddParserToDate
