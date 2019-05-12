#' Display variables that have been defined
#'
#' @param env An environment to look variables from
#' @export
#'
#' @examples
#' opts <- list()
#' opts$a <- 3
#' preint_defined(as.environment(opts))
print_defined <- function(env=parent.frame()) {
  defined <- ls(envir=env)
  defined <- defined[!defined %in% c("doc", "print_defined_")]

  # exclude a variable that starts with '--', e.g. --a, --b
  defined <- defined[!grepl("^--", defined)]

  if(length(defined) == 0) {
    stop("Nothing is defined!")
  }
  values <- lapply(defined, function(x) env[[x]])
  types <- sapply(values, class)
  tibble::tibble(defined=defined,
                 value=unlist(values),
                 type=types
                 )
  res <- mapply(list, defined, types, unlist(values), SIMPLIFY=F)
  cat("─ ", crayon::bold("Variables Passed, Types, & Values")," ─────────────────────────────\n")
  messages <- sapply(res,
    function(x) {
      def  = x[[1]]
      type = x[[2]]
      val = x[[3]]
      formatted <- paste0(def,
                          "(" ,
                          ifelse(type=="character",
                                 crayon::blue(type),
                                 crayon::green(type)
                                 ),
                          ")",
                          ": ",
                          ifelse(type=="character",
                                 crayon::blue(paste0('"', val,'"')),
                                 crayon::green(val)))
      formatted <- paste("✔", formatted)
    })
    cat(messages, sep="\n")
}
