# Test package to extract photo metadata
# combine photo date/time with manual annotations

library(here)
library(exiftoolr)
library(dplyr)
install_exiftool() 
library(readxl)


# Read in annotations
levels <- readxl::read_xlsx(here("data_raw", "AlamoNorth_WaterLevels.xlsx")) %>%
  mutate(date = as.Date(Date, tz = "America/Phoenix"))

# List all photo files and extract metadata
all <- list.files(here("AlamoNorth_Photos"))
output <- c()
for(i in 1:length(all)) {
  info <- exif_read(paste0("AlamoNorth_Photos/", all[i]))
  output <- rbind(output, info)
}

# Select or create relevant columns, join with annotations
out2 <- output %>%
  select(SourceFile, FileName, Directory, FileCreateDate) %>%
  mutate(dt = as.POSIXct(FileCreateDate,
                         format = "%Y:%m:%d %H:%M:%S",
                         tz = "America/Phoenix"),
         date = as.Date(dt, tz = "America/Phoenix")) %>%
  left_join(levels, by = "date")


readr::write_csv(out2, "data_clean/AlamoNorth_annotated.csv")
