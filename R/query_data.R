## author: gmlang

query_data = function(base_url, params) {
        # Performs GET call to API and parses returned XML.
        # Returns a function.
        #
        # base_url: string, base url of API
        # params  : list of search params that will make up API url

        # construct API call and GET data
        request = httr::RETRY("GET", url = make_APIcall(base_url, params))
        check_request(request)
        if (httr::http_type(request) != "application/xml")
                stop("API did not return XML", call. = FALSE)

        # parse
        parsed = xml2::read_xml(httr::content(request, "text"))
        xml2::xml_children(parsed)
}



