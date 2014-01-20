class Search

  def self.model_name
  end

  def self.by(input)
    search = Store.search do
      fulltext input
      paginate :per_page => 9
    end
    search.results
  end

end
