# Predicting-Poverty-with-R
Using Linear Regression in R, to predict poverty among elderly people in the American Midwest 

The dataset contains 16 columns with information on the population and other factors of 437 counties in the American Midwest. Variable names are self-explanatory with those beginning with a "pop" prefix being numbers of population and those with a "per" prefix being percentages of the total population. I am including new variables called "popcollege" and "popprof". These are the population in each county with a college degree, and the population with a professional job. Using the "popchild" and "popadult" variables I am calculating a new variable "ratioca" which will be the ratio of children to adults in each county's population.
Using the "inmetro" variable, I am subdividing the full data set to create two smaller data frames which include only rural and metropolitan counties, respectively. Finally, using a random seed I am taking a random sample of 60 counties from the rural poverty dataset and 30 counties from the metro poverty dataset.

Use the markdown file, poverty_prediction_final to view the project

regression project.R has the actual code

poverty_prediction.Rmd is the markdown file
