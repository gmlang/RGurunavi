## author: gmlang

make_APIcall = function(base_url, params) {
        # base_url: string, base url of API
        # params  : list of parameter values with parameters as names

        # replace all spaces with %20
        params = lapply(params, function(x) gsub(" ", "%20", x))

        # append param names and values into a string like: name=value&...
        args = paste(names(params), params, sep = "=", collapse = "&")

        # return the appropriate url call
        paste0(base_url, "?", args)
}
