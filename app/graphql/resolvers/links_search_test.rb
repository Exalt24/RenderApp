# link_search_test.rb
require 'test_helper'

class LinksSearchTest < ActiveSupport::TestCase
  # Setup for test data
  setup do
    Vote.delete_all
    Link.delete_all
    @link1 = Link.create(description: 'First Link', url: 'http://example1.com')
    @link2 = Link.create(description: 'Second Link with Test', url: 'http://example2.com')
    @link3 = Link.create(description: 'Third Link', url: 'http://example3.com')
  end

  test 'apply_filter with no filters' do
    resolver = Resolvers::LinksSearch.new
    result = resolver.apply_filter(Link.all, nil, nil)

    assert_equal [ @link1, @link2, @link3 ], result.to_a
  end

  test 'apply_filter with description_contains' do
    resolver = Resolvers::LinksSearch.new
    filter = { description_contains: 'Test' }
    result = resolver.apply_filter(Link.all, filter, nil)

    assert_equal [ @link2 ], result.to_a
  end

  test 'apply_filter with url_contains' do
    resolver = Resolvers::LinksSearch.new
    filter = { url_contains: 'example2' }
    result = resolver.apply_filter(Link.all, filter, nil)

    assert_equal [ @link2 ], result.to_a
  end

  test 'apply_filter with OR filter' do
    resolver = Resolvers::LinksSearch.new
    filter = { OR: [
      { description_contains: 'First' },
      { url_contains: 'example3' }
    ]}
    result = resolver.apply_filter(Link.all, filter, nil)

    assert_equal [ @link1, @link3 ], result.to_a
  end

  test 'normalize_filters with empty value' do
    resolver = Resolvers::LinksSearch.new
    assert_equal [], resolver.normalize_filters({})
  end

  test 'normalize_filters with description_contains' do
    resolver = Resolvers::LinksSearch.new
    filter = { description_contains: 'First' }
    result = resolver.normalize_filters(filter)

    assert_equal [ { description: "%First%" } ], result
  end

  test 'normalize_filters with url_contains' do
    resolver = Resolvers::LinksSearch.new
    filter = { url_contains: 'example2' }
    result = resolver.normalize_filters(filter)

    assert_equal [ { url: "%example2%" } ], result
  end

  test 'normalize_filters with OR filter' do
    resolver = Resolvers::LinksSearch.new
    filter = { OR: [
      { description_contains: 'First' },
      { url_contains: 'example3' }
    ]}
    result = resolver.normalize_filters(filter)

    assert_equal [ 
      { description: "%First%" }, 
      { url: "%example3%" } 
    ], result
  end
end