# Example integration in QueryType
module Types
  class QueryType < Types::BaseObject
    field :all_links, resolver: Resolvers::LinksSearch
  end
end
