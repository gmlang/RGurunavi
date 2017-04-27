#' @title Performs GET call to API and parses returned XML.
#' 
#' @description
#' Used internally by all the exported functions.
#' 
#' @param base_url  string, base url of API.
#' @param params    list of search parameters that will make up the URL of a full API call.
#' @return A parsed xml children object.
#' @keywords internal
query_data = function(base_url, params) {
        # construct API call and GET data
        request = httr::RETRY("GET", url = make_APIcall(base_url, params))
        check_request(request)
        if (httr::http_type(request) != "application/xml")
                stop("API did not return XML", call. = FALSE)

        # parse
        parsed = xml2::read_xml(httr::content(request, "text"))
        xml2::xml_children(parsed)
}



