class Search

  def self.model_name
  end

  def self.by(input)
    new_input = input.to_s.strip.downcase.split(' ')
    new_input.each_with_object([]) do |content, results|
      stores_by_name = Store.all.select {|store| store.name.downcase.include? content}
      stores_by_menu = Store.all.select {|store| store.menu.downcase.include? content}
      stores_by_slug = Store.all.select {|store| store.slug.downcase.include? content}
      stores_by_zipcode = Store.all.select {|store| store.zipcode.downcase.include? content}
      results << stores_by_name
      results << stores_by_menu
      results << stores_by_slug
      results << stores_by_zipcode
    end.flatten.uniq

  end

end
