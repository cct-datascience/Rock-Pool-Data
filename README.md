## Rock pool water levels at Organ Pipe Nat'l Monument

This repo contains the annotated data and photo metadata from Susan Washko's dissertation. For each rock pool, Susan indicated the water level (0, 1, 2, or 3) based on a game camera that was motion-activated at least once per day ($3 \leq n \leq 66$). Original photos are available upon request.

### Project question

Can a machine learning (ML) model be devised that can accurately determine rock pool water levels going forward? Some challenges include camera locations that vary slightly, shadows, reflections, and nighttime images.

### Potential applications

If a model can be trained to accurately assign rock pool water levels in Organ Pipe Nat'l Monument, the dataset could be used as a covariate for other wildlife or conservation ecology projects. Furthermore, the data could be used to validate regional hydrological models.

### Repo description

-   `data_raw/` contains .xlsx file(s) sent by Susan
    -   `AlamoNorth_WaterLevels.xlsx` describes daily water levels for a single rock pool 'Alamo North' between 2022-02-06 to 2022-05-17
-   `data_clean/` contains cleaned csv files
    -   `AlamoNorth_annotated.csv` joins the metadata from each photo, including file name, date, and date/time, with the manually annotated water levels for 'Alamo North' between 2022-02-06 to 2022-05-17, which encompasses 1107 photos
-   `scripts/` contains R scripts for processing data
    -   `01-extract-pic-info.R` extracts metadata from each of 1107 photos, parses dates/times, and produces `data_clean/AlamoNorth_annotated.csv`
