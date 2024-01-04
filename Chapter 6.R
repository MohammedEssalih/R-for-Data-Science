library(tidyverse)

students <- read_csv("https://pos.it/r4ds-students-csv")

students |> 
  rename(
    student_id = `Student ID`,
    full_name = `Full Name`
  )

students |> janitor::clean_names()

??janitor

install.packages("janitor")
library(janitor)

students |>
  janitor::clean_names() |>
  mutate(meal_plan = factor(meal_plan))


students <- students |>
  janitor::clean_names() |>
  mutate(
    meal_plan = factor(meal_plan),
    age = parse_number(if_else(age == "five", "5", age))
  )

simple_csv <- "
  x
  10
  .
  20
  30"

read_csv(simple_csv)


df <- read_csv(
  simple_csv, 
  col_types = list(x = col_double())
)
