# Exercise 1: working with data frames (review)

# Install devtools package: allows installations from GitHub
install.packages("devtools")

# Install "fueleconomy" dataset from GitHub
devtools::install_github("hadley/fueleconomy")

# Use the `libary()` function to load the "fueleconomy" package
library(fueleconomy)

# You should now have access to the `vehicles` data frame
# You can use `View()` to inspect it
View(vehicles)

# Select the different manufacturers (makes) of the cars in this data set. 
# Save this vector in a variable
manufacturers <- vehicles$make

# Use the `unique()` function to determine how many different car manufacturers
# are represented by the data set
#unique(vehicles, manufacturers, fromLast = TRUE)
?unique()
length(unique(manufacturers))

# Filter the data set for vehicles manufactured in 1997
cars_1997 <- vehicles[vehicles$year == 1997, ]

# Arrange the 1997 cars by highway (`hwy`) gas milage
# Hint: use the `order()` function to get a vector of indices in order by value
# See also:
# https://www.r-bloggers.com/r-sorting-a-data-frame-by-the-contents-of-a-column/
cars_1997 <- cars_1997[order(cars_1997, hwy), ]

# Mutate the 1997 cars data frame to add a column `average` that has the average
# gas milage (between city and highway mpg) for each car
cars_1997["average"] <- (cars_1997$cty + cars_1997$mpg) / 2

# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city. 
# Save this new data frame in a variable.
cty_mileage <- vehicles$cty > 20
2wd <- vehicles[vehicles$drive == "2-Wheel Drive" & cty_mileage, ]

# Of the above vehicles, what is the vehicle ID of the vehicle with the worst 
# hwy mpg?
# Hint: filter for the worst vehicle, then select its ID.
worst_hwy <- 2wd$id[2wd$hwy == min(2wd$hwy)]

# Write a function that takes a `year_choice` and a `make_choice` as parameters, 
# and returns the vehicle model that gets the most hwy miles/gallon of vehicles 
# of that make in that year.
# You'll need to filter more (and do some selecting)!
mileage_year <- function(year_choice, make_choice) {
  make <- vehicles[vehicles$year == year_choice |
          vehicles$make == make_choice, ]
  model <- make[make$hwy == max(make$hwy), "model"]
}
paste(mileage_year(1995, "Honda"))
# What was the most efficient Honda model of 1995?
mileage_year("Honda", 1995)
