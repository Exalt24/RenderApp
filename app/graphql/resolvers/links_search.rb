require 'search_object'
require 'search_object/plugin/graphql'

module Resolvers
  class LinksSearch < GraphQL::Schema::Resolver
    include SearchObject.module(:graphql)

    type [Types::LinkType], null: true  # Adjust nullability here based on your logic

    # Scope is starting point for search
    scope { Link.all }

    # Inline input type definition for the advanced filter
    class LinkFilter < ::Types::BaseInputObject
      argument :OR, [LinkFilter], required: false
      argument :description_contains, String, required: false
      argument :url_contains, String, required: false
    end

    # When "filter" is passed, "apply_filter" would be called to narrow the scope
    option :filter, type: LinkFilter, with: :apply_filter

    # Apply filters based on input values
    def apply_filter(scope, value)
      branches = normalize_filters(value)
      scope.merge(branches)
    end

    # Normalize filters recursively
    def normalize_filters(value)
      branches = []
      branches << description_filter(value[:description_contains]) if value[:description_contains].present?
      branches << url_filter(value[:url_contains]) if value[:url_contains].present?
      branches.concat(or_filter(value[:OR])) if value[:OR].present?
      branches.reduce(&:or)
    end

    # Filter by description using LIKE clause
    def description_filter(description)
      return Link.none if description.blank?

      Link.where('description LIKE ?', "%#{description}%")
    end

    # Filter by URL using LIKE clause
    def url_filter(url)
      return Link.none if url.blank?

      Link.where('url LIKE ?', "%#{url}%")
    end

    # Apply OR condition recursively
    def or_filter(branches)
      return [] unless branches.present?

      branches.map { |branch| normalize_filters(branch) }
    end

    # Resolve method defines the resolver's behavior
    def resolve(filter: nil)
      scope = apply(filter)
      scope
    end
  end
end
