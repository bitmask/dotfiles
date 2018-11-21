# use the whole screen
wideScreen <- function(howWide=Sys.getenv("COLUMNS")) {
    options(width=as.integer(howWide))
}

# never save the workspace
utils::assignInNamespace(
  "q", 
  function(save = "no", status = 0, runLast = TRUE) 
  {
    .Internal(quit(save, status, runLast))
  }, 
  "base"
)

# ffs, yes, show any scraps of debugging info possible
options(show.error.locations = TRUE)
options(error=function() { if(!interactive()) {traceback(2)}})
