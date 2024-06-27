require "search_object"
require "search_object/plugin/graphql"

module Resolvers
  class LinksSearch < GraphQL::Schema::Resolver
    include SearchObject.module(:graphql)

    type [ Types::LinkType ], null: true

    # Scope is starting point for search
    scope { Link.all }

    class LinkFilter < ::Types::BaseInputObject
      argument :OR, [ LinkFilter ], required: false # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
      argument :description_contains, String, required: false
      argument :url_contains, String, required: false
    end

    option :filter, type: LinkFilter, with: :apply_filter

    def apply_filter(query, value, _ctx)
      branches = normalize_filters(value)
      return query if branches.empty?

      # Apply each branch as a separate query and merge the results
      query = query.none # Start with an empty query
      branches.each do |branch|
        branch_query = Link.all
        branch.each do |key, value|
          if key == :description
            branch_query = branch_query.where("description LIKE ?", value)
          elsif key == :url
            branch_query = branch_query.where("url LIKE ?", value)
          end
        end
        query = query.or(branch_query)
      end
      query
    end

    def normalize_filters(value)
      return [] if value.nil?

      branches = []
      branches << description_filter(value[:description_contains]) if value[:description_contains].present?
      branches << url_filter(value[:url_contains]) if value[:url_contains].present?
      if value[:OR].present?
        or_branches = value[:OR].map { |or_filter| normalize_filters(or_filter) }.flatten
        branches.concat(or_branches)
      end
      branches
    end

    def description_filter(description)
      return Link.none if description.blank?

      # Build the condition correctly
      { description: "%#{description}%" }
    end

    def url_filter(url)
      return Link.none if url.blank?

      # Build the condition correctly
      { url: "%#{url}%" }
    end

    def or_filter(branches)
      return [] unless branches.present?

      branches.map { |branch| normalize_filters(branch) }.flatten
    end

    def call(_obj, args, _ctx)
      # Apply filters to the initial scope
      apply_filter(scope, args[:filter], _ctx)
    end
  end
end
