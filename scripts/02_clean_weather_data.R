# Weather data Read in, clean, and summarize to daily

library(readxl)
library(dplyr)
library(lubridate)

##### Read in from data_raw/ #####
# Middle Bajada
mb_head <- read_xlsx("data_raw/Middle_Bajada_hourly_2022-05-17.xlsx",
                     skip = 1,
                     n_max = 0)
mb <- read_xlsx("data_raw/Middle_Bajada_hourly_2022-05-17.xlsx",
                skip = 4,
                col_names = FALSE) %>%
  setNames(colnames(mb_head)) %>%
  mutate(TIMESTAMP = force_tz(TIMESTAMP, tzone = "America/Phoenix"),
         date = as.Date(TIMESTAMP, tz = "America/Phoenix"))

# Alamo Canyon
ac_head <- read_xlsx("data_raw/Alamo_Canyon_hourly_2022-05-17.xlsx",
                     skip = 1,
                     n_max = 0)
ac <- read_xlsx("data_raw/Alamo_Canyon_hourly_2022-05-17.xlsx",
                skip = 4,
                col_names = FALSE) %>%
  setNames(colnames(ac_head)) %>%
  mutate(TIMESTAMP = force_tz(TIMESTAMP, tzone = "America/Phoenix"),
         date = as.Date(TIMESTAMP, tz = "America/Phoenix"))

##### Summarize to daily #####

mb_daily <- mb %>%
  mutate(RH_mean = rowMeans(select(., RH_Min, RH_Max))) %>%
  group_by(date) %>%
  summarize(airTemp_mean = mean(AirTC_Avg),
            airTemp_max = max(AirTC_Avg),
            airTemp_min = min(AirTC_Avg),
            RH_mean = mean(RH_mean),
            WS_mean = mean(WS_mph_Avg),
            ppt_tot = sum(Rain_in_Tot),
            solarRad_mean = mean(Solar_kwm2_Avg))


ac_daily <- ac %>%
  mutate(RH_mean = rowMeans(select(., RH_Min, RH_Max))) %>%
  group_by(date) %>%
  summarize(airTemp_mean = mean(AirTC_Avg),
            airTemp_max = max(AirTC_Avg),
            airTemp_min = min(AirTC_Avg),
            RH_mean = mean(RH_mean),
            WS_mean = mean(WS_mph_Avg),
            ppt_tot = sum(Rain_in_Tot),
            solarRad_mean = mean(Solar_kwm2_Avg))
  
##### Save out #####

write.csv(mb_daily, file = "data_clean/MiddleBajada_weather_daily.csv", 
          row.names = FALSE)

write.csv(ac_daily, file = "data_clean/AlamoCanyon_weather_daily.csv", 
          row.names = FALSE)
