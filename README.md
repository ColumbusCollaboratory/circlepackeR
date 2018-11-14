# circlepackeR
R htmlwidget for circle packing visualization, for more information please visit the [main page](http://jeromefroe.github.io/circlepackeR/).

A big thank you to [timelyportfolio](https://github.com/timelyportfolio) for his help and major improvements.

#Below is an example of the Columbus Collaboratory's new and improved circlepackeR

library(circlepackeR)

library(data.tree)

library(treemap)

#GNI2014 contains the Gross National Income (per capita) in dollars and population totals of 172 different countries from 2014

data(GNI2014)

head(GNI2014)

GNI2014$pathString <- paste("world", 
                            GNI2014$continent, 
                            GNI2014$country, 
                            sep = "/")
population <- as.Node(GNI2014)

circlepackeR(population, size = "population", color_col="GNI", quartile_values = quantile(GNI2014$GNI))

#@param data data in the form of a hierarchical list

#@param size string represents the size of the circles

#For this program, the size of the circle is based on the population of the countries

#@param color_col string represents the name of the column

#For this program, the name is 'GNI'

#@param quartile_values distributes values amongst 0%, 25%, 50%, 75% and 100% 

#0% - 25% is white

#25% - 50% is light pink

#50% - 75% is dark pink

#75% - 100% is dark red

#For this program, the quartile values are based on the GNI's of the different countries from the GNI2014 data set

#For example, Portugal's GNI is above 75% of all the other countries GNI's so it's dark red.

#NOTICE: When running this program you might have to click "Show in new window" for it to print to the screen

#NOTICE: If you hover over the different circles, they tell you a little information about each country.

#By using the Columbus Collaboratory's version of circlepackeR I was able to make a graph that uses color column and quartile values to show something meaningful
