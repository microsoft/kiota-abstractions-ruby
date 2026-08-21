# frozen_string_literal: true

class QueryParametersMock
  ##
  # Include count of items
  attr_accessor :count
  ##
  # Filter items by property values
  attr_accessor :filter
  ##
  # Order items by property values
  attr_accessor :orderby
  ##
  # Search items by search phrases
  attr_accessor :search
  ##
  # Select properties to be returned
  attr_accessor :select
  ##
  # Skip the first n items
  attr_accessor :skip
  ##
  # Show only the first n items
  attr_accessor :top

  ##
  ## Maps the query parameters names to their encoded names for the URI template parsing.
  ## @param originalName The original query parameter name in the class.
  ## @return a string
  ##
  def get_query_parameter(original_name)
    case original_name
    when 'count'
      '%24count'
    when 'filter'
      '%24filter'
    when 'orderby'
      '%24orderby'
    when 'search'
      '%24search'
    when 'select'
      '%24select'
    when 'skip'
      '%24skip'
    when 'top'
      '%24top'
    else
      originalName
    end
  end
end
