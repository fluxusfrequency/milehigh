class MenuStrain

  def self.by_store(store)
    names = JSON.parse(store.menu)
    names = names.map {|name| name.downcase }
    Strain.all_strains.select {|s| names.include? s.name.downcase }
  end

  def self.find_by_slug(slug)
    Strain.find_by_key(slug)
  end


end
