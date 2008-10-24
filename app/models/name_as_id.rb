NameAsId = classy_module do
  
  def self.find(*args)
    if args.first =~ /[a-zA-Z0-9_-]+/
      send("find_by_#{name_attribute}", args.first)
    else
      super
    end
  end
  
  def to_param
    to_s
  end
  
end