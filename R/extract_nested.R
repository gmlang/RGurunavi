## author: gmlang

extract_nested = function(leaves, size) {
        # Extracts values from nested data structure of a XML object.
        # Used by get_areas_large(), get_areas_middle(), and get_areas_small().
        #
        # leaves : parsed xml children nodes object
        # self   : string of values "l", "m" or "s"

        # make tags to be used to extract embedded data values
        # leaves = xml_children
        # size = "m"
        self_code = paste("areacode", size, sep="_")
        self_name = paste("areaname", size, sep="_")
        pref_code = "pref/pref_code"
        pref_name = "pref/pref_name"

        # extract self data
        df = data.frame(
                sapply(xml2::xml_find_all(leaves, self_code), xml2::xml_text),
                sapply(xml2::xml_find_all(leaves, self_name), xml2::xml_text),
                sapply(xml2::xml_find_all(leaves, pref_code), xml2::xml_text),
                sapply(xml2::xml_find_all(leaves, pref_name), xml2::xml_text)
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
                        sapply(xml2::xml_find_all(leaves, code_search),
                               xml2::xml_text)
                df[[self_l_name]] =
                        sapply(xml2::xml_find_all(leaves, name_search),
                               xml2::xml_text)
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
                        sapply(xml2::xml_find_all(leaves, code_search_l),
                               xml2::xml_text)
                df[[self_l_name]] =
                        sapply(xml2::xml_find_all(leaves, name_search_l),
                               xml2::xml_text)
                df[[self_m_code]] =
                        sapply(xml2::xml_find_all(leaves, code_search_m),
                               xml2::xml_text)
                df[[self_m_name]] =
                        sapply(xml2::xml_find_all(leaves, name_search_m),
                               xml2::xml_text)
        }

        # return
        df
}
