#' @title Extracts values from simple flat data structure of a XML object.
#' 
#' @description
#' Used internally by get_areas(), get_prefs(), get_bizcats() and get_bizsubcats().
#' 
#' @param leaves  Parsed xml children nodes object.
#' @param self    string, node tag that wraps the actual data value.
#' @param foreign string, node tag that wraps the actual data value.
#' 
#' @return
#' A data frame of values extracted from XML file.
#' 
#' @seealso \code{\link{get_areas}}, \code{\link{get_prefs}},
#' \code{\link{get_bizsubcats}}.
#' @keywords internal
extract_simple = function(leaves, self, foreign = NULL) {
        # make tags to be used to extract embedded data values
        self_code = paste(self, "code", sep="_")
        self_name = paste(self, "name", sep="_")
        foreign_code = paste(foreign, "code", sep="_")

        # extract self data
        df = data.frame(
                xml2::xml_text(xml2::xml_find_all(leaves, self_code)),
                xml2::xml_text(xml2::xml_find_all(leaves, self_name))
        )
        names(df) = c(self_code, self_name)

        # add foreign key
        if (!is.null(foreign)) df[[foreign_code]] =
                xml2::xml_text(xml2::xml_find_all(leaves, foreign_code))

        # return
        df
}
