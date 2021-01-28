

# A function for reading in a file that might or might not have metadata
# Metadata follows NWFSC OA standard with first row 
# specifing the row in the file where actual data starts.
# The function reads the first row of the data file to determine 
# whether or not to skip rows for metadata 
read.NWFSC_OA.csv <- function(fileName){
  #read the first row of the data file
  dFirstRow <- read.csv(fileName, stringsAsFactors=FALSE,  nrows = 1, header = FALSE)
  # firstDataRow is the first row of data in the file
  # initialize firstDataRow to 1, which indicates that there is no metadata rows
  firstDataRow <- 1
  #check whether the first cell in the data file is "data_start_row"
  #if so, the file has metadata, 
  # If there is metadata, set firstDataRow as the value in the adjacent cell 
  if(dFirstRow[1,1] == "data_start_row"){
    firstDataRow <- dFirstRow[1,2]
  }
  #read the data file skipping the metadata
  d <- read.csv(fileName, stringsAsFactors=FALSE, skip = firstDataRow -1,
                                  header = TRUE)
  #return the datafile
  return(d)
}

#EXAMPLES
#set the working directory
setwd("/Users/paul.mcelhany/Documents/Github Projects/juvAnalysis")
#example of file without metadata
dNoMeta <- read.NWFSC_OA.csv("Master juv log.csv")
#example of file with metadata
dWithMeta <- read.NWFSC_OA.csv("Master juv log with metadata.csv")