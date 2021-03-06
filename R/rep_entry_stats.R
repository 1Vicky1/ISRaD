#' rep_entry_stats
#'
#' generate report of entry statistics
#'
#' @param database ISRaD data object
#' @import dplyr
#' @import tidyr
#'
#'

rep_entry_stats<-function(database=NULL){
  requireNamespace("dplyr")
  requireNamespace("tidyr")

  entry_stats<-data.frame()
  for(entry in unique(database$metadata$entry_name)){
    ISRaD_data_entry<-lapply(database, function(x) x %>% filter(.data$entry_name==entry) %>% mutate_all(as.character))
    data_stats<-bind_cols(data.frame(entry_name=ISRaD_data_entry$metadata$entry_name, doi=ISRaD_data_entry$metadata$doi), as.data.frame(lapply(ISRaD_data_entry, nrow)))
    data_stats<- data_stats %>% mutate_all(as.character)
    entry_stats<-bind_rows(entry_stats, data_stats)
  }
  return(entry_stats)
}