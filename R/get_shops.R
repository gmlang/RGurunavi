#' @title Implements the Multi-language version Restaurant Search API.
#'
#' @description
#' \url{http://api.gnavi.co.jp/api/manual_e.html#api01}
#'
#' @param api_key string, your own Gurunavi API key. Ours has been provided
#'                for convenience.
#' @param lang    string, language of the returned data. Default = "en", can
#'                also take values of "ja", "zh_cn", "zh_tw", "ko".
#' @param pref_code        string, prefecture code.
#' @param areacode_s       string, small area code.
#' @param category_l_code  string, main biz category code
#' @param category_s_code  string, biz sub-category code
#' @param english_speaking 0 or 1, where 1 means Yes
#' @param korean_speaking  0 or 1, where 1 means Yes
#' @param chinese_speaking 0 or 1, where 1 means Yes
#' @param english_menu     0 or 1, where 1 means Yes
#' @param korean_menu      0 or 1, where 1 means Yes
#' @param chinese_menu     0 or 1, where 1 means Yes
#' @param vegetarian_menu  0 or 1, where 1 means Yes
#' @param wifi             0 or 1, where 1 means Yes
#' @param card             0 or 1, where 1 means Yes
#' @param private_room     0 or 1, where 1 means Yes
#' @param no_smoking       0 or 1, where 1 means Yes
#' @param verbose          TRUE or FALSE, whether to print status messsages
#'
#' @return
#' A data frame of shop info or a warning message when cannot find any records.
#'
#' @seealso \code{\link{query_data}}, \code{\link{extract_shop_info}}
#'
#' @export
#' @examples
#' get_shops(lang = "en", pref_code = "PREF27", areacode_s = "AREAS3144", category_l_code = "RSFST02000", card = 1)
#' get_shops(lang = "ja", pref_code = "PREF27", category_l_code = "RSFST02000", category_s_code = "RSFST02001")
#' get_shops(lang = "zh_cn", pref_code = "PREF27", chinese_menu = 1, chinese_speaking = 1)
#' get_shops(lang = "zh_tw", pref_code = "PREF27", chinese_menu = 1, wifi = 1, card = 1)
#' get_shops(lang = "ko", pref_code = "PREF27", korean_speaking = 1, korean_menu = 1)

get_shops = function(api_key = "eca7388c8a3c6332eb702a21bcc63b46", lang = "en",
                     pref_code        = "",
                     areacode_s       = "",
                     category_l_code  = "",
                     category_s_code  = "",
                     english_speaking = 0,
                     korean_speaking  = 0,
                     chinese_speaking = 0,
                     english_menu     = 0,
                     korean_menu      = 0,
                     chinese_menu     = 0,
                     vegetarian_menu  = 0,
                     wifi             = 0,
                     card             = 0,
                     private_room     = 0,
                     no_smoking       = 1,
                     verbose          = TRUE
                     ) {

        # set search parameters and base API url
        params = list(keyid = api_key, format = "xml", lang = lang,
                      pref = pref_code,
                      areacode_s = areacode_s,
                      category_l = category_l_code,
                      category_s = category_s_code,
                      english_speaking_staff = english_speaking,
                      korean_speaking_staff = korean_speaking,
                      chinese_speaking_staff = chinese_speaking,
                      english_menu = english_menu,
                      korean_menu = korean_menu,
                      simplified_chinese_menu = ifelse(chinese_menu == 1, 1, 0),
                      traditional_chinese_menu = ifelse(chinese_menu == 1, 1, 0),
                      vegetarian_menu_options = vegetarian_menu,
                      wifi = wifi, card = card, private_room = private_room,
                      no_smoking = no_smoking, sort = 1,
                      hit_per_page = 10, offset_page = 1
                      )
        base_url = "https://api.gnavi.co.jp/ForeignRestSearchAPI/20150630/"

        # query first page of 10 shops
        xml_children = query_data(base_url, params)

        # extract meta stats
        tot_shops = as.integer(xml2::xml_text(xml_children[[1]]))
        if (is.na(tot_shops)) {
                return(switch(lang,
                       en = "Can't find what you want. Relax your search criteria.",
                       ja = "お探しの条件が見つかりませんでした。",
                       zh_cn = "找不到您想要的，请放宽要求再搜寻。",
                       zh_tw = "找不到您想要的，請放寬要求再搜尋。",
                       ko = "Can't find what you want. Relax your search criteria."
                       ))
        } else {
                # shops_per_page = as.integer(xml2::xml_text(xml_children[[2]]))
                # start_page = as.integer(xml2::xml_text(xml_children[[3]]))
                shops_per_page = 200
                pages = ceiling(tot_shops / shops_per_page)

                # bulk query and extract all data
                lst_of_dfs = vector("list", length = pages)
                params$hit_per_page = 200
                for (i in 1:pages) {
                        if (verbose) print(paste0("Batch ", i, " of ", pages))
                        params$offset_page = i
                        xml_children = query_data(base_url, params)
                        lst_of_dfs[[i]] = extract_shop_info(xml_children, lang)
                }

                # rbind into a data frame and return
                return(dplyr::bind_rows(lst_of_dfs))
        }
}

