##############################
# Michele Zemplenyi
# 3/15/2021
# Accessing WattTime's API
##############################

library(httr)
library(jsonlite)


## To register, use this code:
register_url <- 'https://api2.watttime.org/v2/register'
# fill in your user information in the "MY_..." fields
params <- list(username = MY_USERNAME, 
               password = MY_PASSWORD, 
               email = MY_EMAIL, 
               org = MY_ORG)
response <- POST(register_url, body = params, encode = "json")
content(response)


## To login, use this code. Be sure to fill in your username and password on the second line.
login_url <- 'https://api2.watttime.org/v2/login'
login_response <- GET(login_url, authenticate('MY_USERNAME','MY_PASSWORD'))
content(login_response)  
# The above command returns your personal token, which expires after 30 min
token <- content(login_response)$token


## To reset your password, use this code:
# Be sure to fill in your username at the end of the line below
password_url <- modify_url('https://api2.watttime.org/v2/password', query = list(username = "MY_USERNAME"))
reset_response <- GET(password_url)
content(reset_response)


## Determine grid region: make sure to add in your registered
# MY_USERNAME and MY_PASSWORD in the second line.
# You should not manually add in your token here. 
# The code automatically generates a new token each time you run it.
# First login and get your token
login_url <- 'https://api2.watttime.org/v2/login'
login_response <- GET(login_url, authenticate('MY_USERNAME','MY_PASSWORD'))
token <- content(login_response)$token
# Then query for the grid region:
region_url <- 'https://api2.watttime.org/v2/ba-from-loc'
params <- list(latitude = '42.372', longitude = '-72.519')
region_response <- GET(region_url, add_headers(Authorization = paste0('Bearer ',token)), query = params)
content(region_response)


## Realtime emissions: preview the index data provided by using
# grid region CAISO_NORTH for your requests
index_url <- 'https://api2.watttime.org/index'
params <- list(ba = 'CAISO_NORTH')
index_response <- GET(index_url, add_headers(Authorization = paste0('Bearer ',token)), query = params)
content(index_response)
