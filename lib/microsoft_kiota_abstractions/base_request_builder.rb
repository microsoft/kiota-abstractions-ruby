module MicrosoftKiotaAbstractions
    class BaseRequestBuilder
        ## 
        # Path parameters for the request
        @path_parameters
        ## 
        # The request adapter to use to execute the requests.
        @request_adapter
        ## 
        # Url template to use to build the URL for the current request builder
        @url_template
        ## 
        ## Instantiates a new BaseRequestBuilder and sets the default values.
        ## @param path_parameters Path parameters for the request
        ## @param request_adapter The request adapter to use to execute the requests.
		## @param url_template Url template to use to build the URL for the current request builder
        ## @return a void
        ## 
        def initialize(path_parameters, request_adapter, url_template)
            raise StandardError, 'request_adapter cannot be null' if request_adapter.nil?
			raise StandardError, 'url_template cannot be null' if url_template.nil? || url_template.empty?
            @request_adapter = request_adapter
            unless path_parameters.nil? then
                if path_parameters.is_a? Hash then
                    @path_parameters = path_parameters.clone
                elsif path_parameters.is_a? String then
                    @path_parameters = { "request-raw-url" => path_parameters }
                end
            end
            @path_parameters = Hash.new if path_parameters.nil?
			@url_template = url_template
        end
    end
end