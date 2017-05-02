#' @title Construct the URL of the full API call.
#' 
#' @description
#' Used internally by query_data().
#' 
#' @param base_url  string, base url of API.
#' @param params    list of parameter values.
#' @return url of full API call.
#' @seealso \code{\link{query_data}}.
#' @keywords internal
make_APIcall = function(base_url, params) {
        # replace all spaces with %20
        params = lapply(params, function(x) gsub(" ", "%20", x))

        # append param names and values into a string like: name=value&...
        args = paste(names(params), params, sep = "=", collapse = "&")

        # return the appropriate url call
        paste0(base_url, "?", args)
}
