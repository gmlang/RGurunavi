## author: gmlang

extract_simple = function(leaves, self, foreign = NULL) {
        # Extracts values from simple flat data structure of a XML object.
        # Used by get_areas(), get_prefs(), get_bizcats() and get_bizsubcats().
        #
        # leaves : parsed xml children nodes object
        # self   : string, node tag that wraps the actual data value
        # foreign: string, node tag that wraps the actual data value

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
