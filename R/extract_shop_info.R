#' @title Extracts shop info from nested data structure of a XML object.
#' 
#' @description
#' Used internally by get_shops().
#' 
#' @param leaves Parsed xml children nodes object.
#' @param lang   string, language of the returned data. Default = "en", can 
#'               also take values of "ja", "zh_cn", "zh_tw", "ko".
#' 
#' @return
#' A data frame of shop info extracted from XML file.
#' 
#' @seealso \code{\link{get_shops}}.

extract_shop_info = function(leaves, lang="en") {
        # extract values
        id = xml2::xml_text(xml2::xml_find_all(leaves, "id"))
        update_date = xml2::xml_text(xml2::xml_find_all(leaves, "update_date"))
        name = xml2::xml_text(xml2::xml_find_all(leaves, "name/name"))
        biz_hr = xml2::xml_text(xml2::xml_find_all(leaves, "business_hour"))
        holiday = xml2::xml_text(xml2::xml_find_all(leaves, "holiday"))
        address = xml2::xml_text(xml2::xml_find_all(leaves, "contacts/address"))
        tel = xml2::xml_text(xml2::xml_find_all(leaves, "contacts/tel"))
        fax = xml2::xml_text(xml2::xml_find_all(leaves, "contacts/fax"))
        selling_point_short = xml2::xml_text(xml2::xml_find_all(leaves, "sales_points/pr_short"))
        selling_point_long = xml2::xml_text(xml2::xml_find_all(leaves, "sales_points/pr_long"))
        access = xml2::xml_text(xml2::xml_find_all(leaves, "access"))
        price = xml2::xml_text(xml2::xml_find_all(leaves, "budget")) # in Japanese Yen
        credit_card = xml2::xml_text(xml2::xml_find_all(leaves, "credit_card"))

        tmp = xml2::xml_find_all(leaves, "categories/category_name_l")
        order = as.integer(xml2::xml_attr(tmp, "order"))
        categoryL = xml2::xml_text(tmp)
        categoryL0 = categoryL[order == 0]
        categoryL1 = categoryL[order == 1]

        tmp = xml2::xml_find_all(leaves, "categories/category_name_s")
        order = as.integer(xml2::xml_attr(tmp, "order"))
        categoryS = xml2::xml_text(tmp)
        categoryS0 = categoryS[order == 0]
        categoryS1 = categoryS[order == 1]

        mobile_site = xml2::xml_text(xml2::xml_find_all(leaves, "flags/mobile_site"))
        mobile_coupon = xml2::xml_text(xml2::xml_find_all(leaves, "flags/mobile_coupon"))
        pc_coupon = xml2::xml_text(xml2::xml_find_all(leaves, "flags/pc_coupon"))
        district = xml2::xml_text(xml2::xml_find_all(leaves, "location/area/district"))
        prefecture = xml2::xml_text(xml2::xml_find_all(leaves, "location/area/prefname"))
        areaS = xml2::xml_text(xml2::xml_find_all(leaves, "location/area/areaname_s"))
        url_web = xml2::xml_text(xml2::xml_find_all(leaves, "url"))
        url_thumbnail = xml2::xml_text(xml2::xml_find_all(leaves, "image_url/thumbnail"))
        if (lang != "ja") {
                name_sub = xml2::xml_text(xml2::xml_find_all(leaves, "name/name_sub"))
                areaL = xml2::xml_text(xml2::xml_find_all(leaves, "location/area/areaname_l"))
                areaM = xml2::xml_text(xml2::xml_find_all(leaves, "location/area/areaname_m"))
                categoryK = rep("", length(id))
                url_mobile = rep("", length(id))
                url_qrcode = rep("", length(id))
        } else {
                name_sub = xml2::xml_text(xml2::xml_find_all(leaves, "name/name_kana"))
                areaL = rep("", length(id))
                areaM = rep("", length(id))
                categoryK = xml2::xml_text(xml2::xml_find_all(leaves, "categories/category"))
                url_mobile = xml2::xml_text(xml2::xml_find_all(leaves, "url_mobile"))
                url_qrcode = xml2::xml_text(xml2::xml_find_all(leaves, "image_url/qrcode"))
        }

        # return a data frame
        data.frame(id, update_date, name, name_sub,
                   categoryK, categoryL0, categoryL1, categoryS0, categoryS1,
                   selling_point_short, selling_point_long,
                   district, prefecture, areaL, areaM, areaS,
                   biz_hr, holiday, price, mobile_coupon, pc_coupon,
                   credit_card, mobile_site,
                   address, access, tel, fax,
                   url_web, url_mobile, url_thumbnail, url_qrcode,
                   stringsAsFactors = F)
}
