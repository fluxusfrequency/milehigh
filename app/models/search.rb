class Search

  def self.by(input)
    search = Store.search do
      fulltext input
    end
    search.results
  end

end
