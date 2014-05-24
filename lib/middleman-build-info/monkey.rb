class String
  def without_leading_slash
    self.gsub(/^\//,'')
  end
end