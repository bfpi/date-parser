require 'date'

module AddParserToDate
  def new(*args)
    return super if args.length != 1
    value = args.first
    return if value.nil?
    return value if value.is_a?(Date)
    return super unless value.is_a?(String)

    value.strip!
    begin
      if value =~ /^([0]?[1-9]|[12][0-9]|3[01])\.([0]?[1-9]|[1][0-2])\.[0-9]{2}$/
        Date.strptime(value, "%d.%m.%y")
      elsif value =~ /^([0]?[1-9]|[12][0-9]|3[01])([.-])([0]?[1-9]|[1][0-2])([.-])[0-9]{4}$/
        Date.strptime(value, "%d#{ $2 }%m#{ $4 }%Y")
      elsif value =~ /^[0-9]{6}$/
        Date.strptime("#{value[0..1]}.#{value[2..3]}.#{value[4..5]}", "%d.%m.%y")
      elsif value =~ /^[0-9]{8}$/
        Date.strptime("#{value[0..1]}.#{value[2..3]}.#{value[4..7]}", "%d.%m.%Y")
      elsif value =~ /^[0-9]{2}-([0]?[1-9]|[1][0-2])-([0]?[1-9]|[12][0-9]|3[01])$/
        Date.strptime(value, "%y-%m-%d")
      elsif value =~ /^[0-9]{4}-([0]?[1-9]|[1][0-2])-([0]?[1-9]|[12][0-9]|3[01])$/
        Date.strptime(value, "%Y-%m-%d")
      else
        nil
      end
    rescue ArgumentError
      nil
    end
  end
end

Date.singleton_class.prepend AddParserToDate
