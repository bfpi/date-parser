require 'date'

module AddParserToDateTime
  def new(*args)
    return super if args.length != 1
    value = args.first
    return if value.nil?
    return value if value.is_a?(DateTime) || value.is_a?(Time)
    return value.to_datetime if value.is_a?(Date)
    return super unless value.is_a?(String)

    value.strip!
    begin
      date, time = value.split(/[ T]/, 2)
      date = Date.new(date)
      return if date.nil?
      
      if time =~ /^(0[0-9]|1[0-9]|2[0-4])[\.\:]?([0-5][0-9])([\.\:]?([0-5][0-9]))?( ?[A-Z]+|(\+|-)(0[0-9]|1[0-2])(:[0-5][0-9])?)?$/
        DateTime.new date.year, date.mon, date.day, $1.to_i, $2.to_i, ($4 || 0).to_i, $5 || ''
      else
        nil
      end
    rescue ArgumentError
      nil
    end
  end
end

DateTime.singleton_class.prepend AddParserToDateTime
