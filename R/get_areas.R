## author: gmlang

get_areas = function(api_key = "eca7388c8a3c6332eb702a21bcc63b46",
                     lang = "en") {
        # Implements the Acquire Area Master API.
        # Returns a data frame of a look up table of area codes and names.
        #
        # api_key      : string, your own Gurunavi API key. Ours has been
        #                provided for convenience.
        # lang         : string, language of the returned data. Default = "en",
        #                can also take values of "ja", "zh_cn", "zh_tw", "ko".

        # set search parameters and base API url
        params = list(keyid = api_key, lang = lang, format = "xml")
        base_url = "https://api.gnavi.co.jp/master/AreaSearchAPI/20150630/"

        # construct API call and GET data
        request = httr::RETRY("GET", url = make_APIcall(base_url, params))
        check_request(request)
        if (httr::http_type(request) != "application/xml")
                stop("API did not return XML", call. = FALSE)

        # parse
        parsed = xml2::read_xml(httr::content(request, "text"))
        leaves = xml2::xml_children(parsed)

        # extract data
        area_code = sapply(xml2::xml_find_all(leaves, "area_code"),
                           xml2::xml_text)
        area_name = sapply(xml2::xml_find_all(leaves, "area_name"),
                           xml2::xml_text)

        # return
        data.frame(area_code, area_name)
}

