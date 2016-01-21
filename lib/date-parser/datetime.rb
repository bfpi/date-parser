require 'date'

module AddParserToDateTime
  def new(*args)
    if args.length == 1
      value = args.first
      return value if value.is_a?(DateTime)
      return super unless value.is_a?(String)

      value.strip!
      begin
        spl = value.split(/[ T]/)
        date = Date.new(spl.first)
        return nil if date.nil?
        
        datetime = date.to_datetime
        time = spl.last
        if time =~ /^(0[0-9]|1[0-9]|2[0-4])[\.\:]([0-5][0-9])$/
          datetime.change(hour: time[0..1].to_i, min: time[3..4].to_i)
        elsif time =~ /^(0[0-9]|1[0-9]|2[0-4])([0-5][0-9])$/
          datetime.change(hour: time[0..1].to_i, min: time[2..3].to_i)
        else
          nil
        end
      rescue ArgumentError
        nil
      end
    else
      super
    end
  end
end

DateTime.singleton_class.prepend AddParserToDateTime
