#' @title Implements the Acquire Business Subcategory Master API.
#' 
#' @description
#' \url{http://api.gnavi.co.jp/api/manual_e.html#api08}
#' 
#' @param api_key string, your own Gurunavi API key. Ours has been provided
#'                for convenience.
#' @param lang    string, language of the returned data. Default = "en", can
#'                also take values of "ja", "zh_cn", "zh_tw", "ko".
#'                
#' @return
#' A data frame of biz subcategory and category codes and names.
#' 
#' @seealso \code{\link{query_data}}, \code{\link{extract_simple}}
#' 
#' @export
#' @examples
#' get_bizsubcats(lang = "en")
#' get_bizsubcats(lang = "ja")
#' get_bizsubcats(lang = "zh_cn")
#' get_bizsubcats(lang = "zh_tw")
#' get_bizsubcats(lang = "ko")

get_bizsubcats = function(api_key = "eca7388c8a3c6332eb702a21bcc63b46",
                          lang = "en") {
        # set search parameters and base API url
        params = list(keyid = api_key, lang = lang, format = "xml")
        base_url = "https://api.gnavi.co.jp/master/CategorySmallSearchAPI/20150630/"

        # query and parse data
        xml_children = query_data(base_url, params)

        # extract data values
        extract_simple(xml_children, self = "category_s", foreign="category_l")
}


