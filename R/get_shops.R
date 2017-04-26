## author: gmlang
## depends on dplyr

get_shops = function(api_key = "eca7388c8a3c6332eb702a21bcc63b46",
                     lang = "en",
                     pref = "",
                     areacode_s = "",
                     category_l = "",
                     category_s = "",
                     english_speaking = 0,
                     korean_speaking  = 0,
                     chinese_speaking = 0,
                     english_menu     = 0,
                     korean_menu      = 0,
                     chinese_menu     = 0,
                     vegetarian_menu  = 0,
                     wifi = 0,
                     card = 0,
                     private_room = 0,
                     no_smoking   = 1,
                     hit_per_page = 10,
                     offset_page  = 1,
                     verbose = TRUE
                     ) {
        # Implements the Multi-language version Restaurant Search API.
        # Returns a data frame of shop info.
        #
        # api_key    : string, your own Gurunavi API key. Ours has been provided
        #              for convenience.
        # lang       : string, language of the returned data. Default = "en",
        #              other possible values are "ja", "zh_cn", "zh_tw", "ko".
        # pref       : string, prefecture code via the prefecture API.
        # areacode_s : string, small area code via the acquire area small API.
        # category_l : string, main biz category code via the acquire main
        #              business category API.
        # category_s : string, biz sub-category code via the acquire business
        #              subcategory API.
        # english_speaking  : 0 or 1, where 1 means Yes
        # korean_speaking   : 0 or 1, where 1 means Yes
        # chinese_speaking  : 0 or 1, where 1 means Yes
        # english_menu      : 0 or 1, where 1 means Yes
        # korean_menu       : 0 or 1, where 1 means Yes
        # chinese_menu      : 0 or 1, where 1 means Yes
        # vegetarian_menu   : 0 or 1, where 1 means Yes
        # wifi: 0 or 1, where 1 means Yes
        # card: 0 or 1, where 1 means Yes
        # private_room: 0 or 1, where 1 means Yes
        # no_smoking  : 0 or 1, where 1 means Yes
        # hit_per_page: number of shops listed on a page, default = 10
        # offset_page : search starting page, default = 1
        # verbose: TRUE or FALSE, whether to print messsages

        # set search parameters and base API url
        params = list(keyid = api_key, format = "xml", lang = lang, pref = pref,
                      areacode_s = areacode_s, category_l = category_l,
                      category_s = category_s,
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
                      hit_per_page = hit_per_page, offset_page = offset_page
                      )
        base_url = "https://api.gnavi.co.jp/ForeignRestSearchAPI/20150630/"

        # query first page of 10 shops
        xml_children = query_data(base_url, params)

        # extract meta stats
        tot_shops = as.integer(xml2::xml_text(xml_children[[1]]))
        if (is.na(tot_shops))
                stop("Can't find restaurants that meet your criteria. Relax your search criteria.")
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
        dplyr::bind_rows(lst_of_dfs)
}

