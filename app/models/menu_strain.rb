class MenuStrain

  def self.by_store(store)
    names = JSON.parse(store.menu)
    names = names.map {|name| name.downcase }
    strains = Strain.all_strains.select {|s| names.include? s.name.downcase }
  end


end
