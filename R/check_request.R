## author: gmlang

check_request = function(request) {
        # request: object returned by GET()

        # if the request wasn't successful, stop
        if (request$status_code != 200)
                stop("Gurunavi's API returned an error.\n")
}
