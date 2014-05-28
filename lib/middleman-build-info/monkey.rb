class String
  def without_leading_slash
    self.gsub(/^\//,'')
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