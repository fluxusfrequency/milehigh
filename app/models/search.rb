class Search

  def self.model_name
  end

  def self.by(input)
    search = Store.search do
      fulltext input
    end
    search.results
  end

end
