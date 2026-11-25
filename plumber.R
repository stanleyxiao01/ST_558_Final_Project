library(plumber)
library(tidymodels)
library(ranger)

# Load the fitted model
final_model <- readRDS("final_model.rds")

# Example API calls:
# http://localhost:8000/pred
# http://localhost:8000/pred?age=35&balance=2000&duration=300
# http://localhost:8000/pred?job=management&housing=no&duration=600

#* Predict term deposit subscription
#* @param age Customer age
#* @param job Job type
#* @param marital Marital status
#* @param education Education level
#* @param default Credit in default
#* @param balance Average yearly balance
#* @param housing Housing loan
#* @param loan Personal loan
#* @param contact Contact type
#* @param day Day of last contact
#* @param month Month of last contact
#* @param duration Duration of last contact in seconds
#* @param campaign Number of contacts during the current campaign
#* @param pdays Days since previous campaign contact
#* @param previous Number of contacts before the current campaign
#* @param poutcome Outcome of previous campaign
#* @get /pred
function(age = 40.9, job = "blue-collar", marital = "married",
         education = "secondary", default = "no", balance = 1362,
         housing = "yes", loan = "no", contact = "cellular",
         day = 15.8, month = "may", duration = 258,
         campaign = 2.76, pdays = 40.2, previous = 0.580,
         poutcome = "unknown") {
  
  new_customer <- tibble(
    age = as.numeric(age),
    job = factor(job),
    marital = factor(marital),
    education = factor(education),
    default = factor(default),
    balance = as.numeric(balance),
    housing = factor(housing),
    loan = factor(loan),
    contact = factor(contact),
    day = as.numeric(day),
    month = factor(month),
    duration = as.numeric(duration),
    campaign = as.numeric(campaign),
    pdays = as.numeric(pdays),
    previous = as.numeric(previous),
    poutcome = factor(poutcome)
  )
  
  # Obtain predicted class and probabilities
  predicted_class <- predict(final_model, new_data = new_customer)
  predicted_prob <- predict(final_model, new_data = new_customer,
                            type = "prob")
  
  bind_cols(predicted_class, predicted_prob)
}

#* Return project information
#* @get /info
function() {
  list(name = "Stanley Xiao",
       url = "https://stanleyxiao01.github.io/ST_558_Final_Project/")
}
