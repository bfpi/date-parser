require 'date'

module AddParserToDateTime
  def new(*args)
    return super if args.length != 1
    value = args.first
    return value if value.is_a?(DateTime)
    return super unless value.is_a?(String)

    value.strip!
    begin
      date, time = value.split(/[ T]/, 2)
      date = Date.new(date)
      return if date.nil?
      
      datetime = date.to_datetime
      if time =~ /^(0[0-9]|1[0-9]|2[0-4])[\.\:]?([0-5][0-9])$/
        datetime.change(hour: $1.to_i, min: $2.to_i)
      else
        nil
      end
    rescue ArgumentError
      nil
    end
  end
end

DateTime.singleton_class.prepend AddParserToDateTime
