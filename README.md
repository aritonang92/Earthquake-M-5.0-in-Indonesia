# Plot 60 latest earthquake above M 5.0 event in Indonesia
This repository tells about where earthquakes occur in Indonesia. I use R with some libraries ('tidyverse', 'raster', 'stringr' and so on). The roadmap of these are : 

1. Extracted data from BMKG official portal, it was XML file. I converted this to .xlsx file and upload it to RStudio project
2. Do usual data cleaning as needed (Change the class of each column of data, subsetting, split data into some column, and remove some column that not needed)
3. Use 'raster' library and choose Indonesia's map (you can follow the steps on website https://www.gis-blog.com/r-raster-data-acquisition/) and then plot the locations regarding to its location on map (latitude and longitude) this information is provided on formatted data.  
