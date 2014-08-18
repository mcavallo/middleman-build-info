class String

  def without_leading_slash
    self.gsub(/^\//,'')
  end

  def pluralized_count count, plural=nil
    if count == 1
      "1 #{self}"
    elsif plural
      "#{count} #{plural}"
    else
      "#{count} #{self}s"
    end
  end

end

class Hash

  def symbolize_keys
    self.inject({}) do |result, (key, value)|
      new_key = case key
                when String then key.to_sym
                else key
                end
      new_value = case value
                  when Hash then symbolize_keys(value)
                  else value
                  end
      result[new_key] = new_value
      result
    end
  end

end