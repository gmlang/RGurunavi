## author: gmlang

get_bizsubcats = function(api_key = "eca7388c8a3c6332eb702a21bcc63b46",
                          lang = "en") {
        # Implements the Acquire Main Business Subcategory Master API.
        # Returns a data frame of biz category codes and names and subcat codes.
        #
        # api_key      : string, your own Gurunavi API key. Ours has been
        #                provided for convenience.
        # lang         : string, language of the returned data. Default = "en",
        #                can also take values of "ja", "zh_cn", "zh_tw", "ko".

        # set search parameters and base API url
        params = list(keyid = api_key, lang = lang, format = "xml")
        base_url = "https://api.gnavi.co.jp/master/CategorySmallSearchAPI/20150630/"

        # query and parse data
        xml_children = query_data(base_url, params)

        # extract data values
        extract_simple(xml_children, self = "category_s", foreign="category_l")
}


