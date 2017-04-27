#' @title Check if API request returns an error or success.
#' 
#' @description
#' Stop and print an error message if API call doesn't return 200 status code.
#' 
#' @param request Object returned by GET()
#' 
#' @return 
#' Nothing.

check_request = function(request) {
        # request: object returned by GET()

        # if the request wasn't successful, stop
        if (request$status_code != 200)
                stop("Gurunavi's API returned an error.\n")
}
