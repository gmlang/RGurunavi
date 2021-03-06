#' @title Implements the Prefecture Master API.
#' 
#' @description
#' \url{http://api.gnavi.co.jp/api/manual_e.html#api03}
#' 
#' @param api_key string, your own Gurunavi API key. Ours has been provided
#'                for convenience.
#' @param lang    string, language of the returned data. Default = "en", can
#'                also take values of "ja", "zh_cn", "zh_tw", "ko".
#'                
#' @return
#' A data frame of prefecture codes and names and area codes.
#' 
#' @seealso \code{\link{query_data}}, \code{\link{extract_simple}}
#' 
#' @export
#' @examples
#' get_prefs(lang = "en")
#' get_prefs(lang = "ja")
#' get_prefs(lang = "zh_cn")
#' get_prefs(lang = "zh_tw")
#' get_prefs(lang = "ko")

get_prefs = function(api_key = "eca7388c8a3c6332eb702a21bcc63b46",
                     lang = "en") {
        # set search parameters and base API url
        params = list(keyid = api_key, lang = lang, format = "xml")
        base_url = "https://api.gnavi.co.jp/master/PrefSearchAPI/20150630/"

        # query and parse data
        xml_children = query_data(base_url, params)

        # extract data values
        extract_simple(xml_children, self = "pref", foreign = "area")
}


