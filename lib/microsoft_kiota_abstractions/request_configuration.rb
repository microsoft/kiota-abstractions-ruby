module MicrosoftKiotaAbstractions
    ## 
    # Configuration for the request such as headers, query parameters, and middleware options.
    class RequestConfiguration
        ## 
        # Request headers
        attr_accessor :headers
        ## 
        # Request options
        attr_accessor :options
        ## 
        # Request query parameters
        attr_accessor :query_parameters
    end
end