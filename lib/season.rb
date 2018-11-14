require 'date'

class Date
  def season
    day_hash = month * 100 + mday
    case day_hash
      when 101..401 then 'Invierno'
      when 402..630 then 'Primavera'
      when 701..930 then 'Verano'
      when 1001..1231 then 'Otoño'
    end
  end
end
