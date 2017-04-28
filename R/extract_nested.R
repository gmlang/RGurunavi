#' @title Extracts values from nested data structure of a XML object.
#' 
#' @description
#' Used internally by get_areas_large(), get_areas_middle() and get_areas_small().
#' 
#' @param leaves Parsed xml children nodes object.
#' @param self string of values "l", "m" or "s".
#' 
#' @return
#' A data frame of values extracted from XML file.
#' 
#' @seealso \code{\link{get_areas_large}}, \code{\link{get_areas_middle}},
#' \code{\link{get_areas_small}}.
#' @keywords internal
extract_nested = function(leaves, size) {
        # make tags to be used to extract embedded data values
        self_code = paste("areacode", size, sep="_")
        self_name = paste("areaname", size, sep="_")
        pref_code = "pref/pref_code"
        pref_name = "pref/pref_name"

        # extract self data
        df = data.frame(
                xml2::xml_text(xml2::xml_find_all(leaves, self_code)),
                xml2::xml_text(xml2::xml_find_all(leaves, self_name)),
                xml2::xml_text(xml2::xml_find_all(leaves, pref_code)),
                xml2::xml_text(xml2::xml_find_all(leaves, pref_name)),
                stringsAsFactors = F
                )
        names(df) = c(self_code, self_name, gsub("pref/", "", pref_code),
                      gsub("pref/", "", pref_name))

        # extract nested data
        if (size == "m") {
                self_l_code = gsub("_m", "_l", self_code)
                self_l_name = gsub("_m", "_l", self_name)
                code_search = paste0("garea_large/", self_l_code)
                name_search = paste0("garea_large/", self_l_name)
                df[[self_l_code]] =
                        xml2::xml_text(xml2::xml_find_all(leaves, code_search))
                df[[self_l_name]] =
                        xml2::xml_text(xml2::xml_find_all(leaves, name_search))
        }

        if (size == "s") {
                self_l_code = gsub("_s", "_l", self_code)
                self_l_name = gsub("_s", "_l", self_name)
                self_m_code = gsub("_s", "_m", self_code)
                self_m_name = gsub("_s", "_m", self_name)
                code_search_l = paste0("garea_large/", self_l_code)
                name_search_l = paste0("garea_large/", self_l_name)
                code_search_m = paste0("garea_middle/", self_m_code)
                name_search_m = paste0("garea_middle/", self_m_name)

                df[[self_l_code]] =
                        xml2::xml_text(xml2::xml_find_all(leaves, code_search_l))
                df[[self_l_name]] =
                        xml2::xml_text(xml2::xml_find_all(leaves, name_search_l))
                df[[self_m_code]] =
                        xml2::xml_text(xml2::xml_find_all(leaves, code_search_m))
                df[[self_m_name]] =
                        xml2::xml_text(xml2::xml_find_all(leaves, name_search_m))
        }

        # return
        df
}
