library(tidyverse)
library(nycflights13)

# Strive for:
short_flights <- flights |> filter(air_time < 60)

# Avoid:
SHORTFLIGHTS <- flights |> filter(air_time < 60)


# Strive for 
flights |>  
  filter(!is.na(arr_delay), !is.na(tailnum)) |> 
  count(dest)

# Avoid
flights|>filter(!is.na(arr_delay), !is.na(tailnum))|>count(dest)


flights |> 
  group_by(dest) |> 
  summarize(
    distance = mean(distance),
    speed = mean(distance / air_time, na.rm = TRUE)
  ) |> 
  ggplot(aes(x = distance, y = speed)) +
  geom_smooth(
    method = "loess",
    span = 0.5,
    se = FALSE, 
    color = "red", 
    linewidth = 1
  ) +
  geom_point()




flights |>
  filter(dest=="IAH") |>
  group_by(year,month,day) |>
  summarize(n=n(),
            delay=mean(arr_delay,na.rm=TRUE)) |>
  filter(n>10)

flights |>
  filter(carrier=="UA",
         dest%in%c("IAH","HOU"),
         sched_dep_time>0900,
         sched_arr_time<2000) |>
  group_by(flight) |>
  summarize(delay=mean(arr_delay,na.rm=TRUE),
            cancelled=sum(is.na(arr_delay)),
            n=n()) |>
  filter(n>10)