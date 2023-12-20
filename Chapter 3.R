install.packages("nycflights13")
library(nycflights13)
library(tidyverse)


  flights |>
  filter(dest == "IAH") |> 
  group_by(year, month, day) |> 
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )
Data=flights |> 
  filter(dep_delay == 120)

flights|>
  distinct(dest)

# 3.2.5 Exercises
#1) Had an arrival delay of two or more hours:
flights |> 
  filter(arr_delay>=120)
#2) Flew to Houston (IAH or HOU)

flights |> 
  filter(dest%in%c("IAH","HOU"))

#3) Were operated by United, American, or Delta
flights |> 
  filter(carrier %in% c("DL","AA","UA"))

#4) Departed in summer (July, August, and September)
flights |>
  filter(month %in% c(7, 8, 9))
#5) Arrived more than two hours late, but didn't leave late
flights |>
  filter(arr_delay>120, dep_delay<=0)
#6 Were delayed by at least an hour, but made up over 30 minutes in flight
flights |>
  filter(dep_delay>=60, air_time>30)

# Sort flights to find the flights with longest departure delays. Find the flights that left earliest in the morning.
flights |>
  arrange(-dep_delay)

flights |>
  filter(dep_time%in%c(0:500))

# Sort flights to find the fastest flights. (Hint: Try including a math calculation inside of your function.)
flights |>
  arrange(distance/air_time)

# Was there a flight on every day of 2013?
flights |>
  distinct(month,day)
# The size is 356, So, yes

# Which flights traveled the farthest distance? Which traveled the least distance?
data=flights |>
  arrange(distance)

data=data|>
  distinct(data$distance)
data[length(data$`data$distance`),]

# Does it matter what order you used filter() and arrange() if you're using both? Why/why not? Think about the results and how much work the functions would have to do.
#There is no difference. Actually, the arrange function will arrange the data and the filter function will filter it. In the end, we will have the same data. But to win time, it is preferable to use the filter function before the arrange function

#3.3 Columns
#mutate function

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 3
  )

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )  
flights |> 
  select(where(is.character))

flights |>
  relocate(dep_delay)

# 3.3.5 Exercises
# Compare dep_time, sched_dep_time, and dep_delay. 
# How would you expect those three numbers to be related?
flights |>
  select(dep_time,sched_dep_time,dep_delay)
flights$dep_delay-(flights$dep_time-flights$sched_dep_time)

# Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.
#3 What happens if you specify the name of the same variable multiple times in a select() call?

flights |>

    select(year,year)
#5 
flights |> select(contains("TIME"))
#6Rename air_time to air_time_min to indicate units of measurement and move it to the beginning of the data frame.

flights %>%
  rename(air_time_min=air_time)|>
  relocate(air_time_min)

#7 Why doesn't the following work, and what does the error mean?
flights |> 
  select(tailnum) |> 
  arrange(tailnum)

# The pipe
flights |> 
  filter(dest == "IAH") |> 
  mutate(speed = distance / air_time * 60) |> 
  select(year:day, dep_time, carrier, flight, speed) |> 
  arrange(desc(speed))

#3.5 Groups
Thi_is_my_token="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"

flights |> 
  group_by(dep_delay)

flights |> 
  group_by(month) |> 
  summarize(
    max_delay = max(dep_delay, na.rm = T),
    repetition=n()
  )
# The slice_ functions
flights|>
  group_by(day)|>
  slice_min(month,n=1)

flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1, with_ties = FALSE) |>
  relocate(dest)

flights |>  
  group_by(year, month, day)|>
  summarise(n=n(),.groups = "drop_last")
  

flights |>  
  group_by(year, month, day)|>
  summarise(n=n())

#3.5.5 Ungrouping

flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = month
  )
# Exercises 
# Which carrier has the worst average delays?
flights |>
  group_by(carrier)|>
  summarise(avrg=mean(dep_delay,na.rm = T))|>
  arrange(avrg)

flights |>
  group_by(carrier)|>
  summarise(avrg=mean(dep_delay,na.rm = T))|>
  arrange(avrg)
  
flights |> 
  group_by(carrier, dest) |> 
  summarize(n())
# Find the flights that are most delayed upon departure from each destination.
flights$flight
flights |> 
  group_by(dest, flight) |> 
  summarize(delay=max(dep_delay, na.rm = T))
  
# How do delays vary over the course of the day. Illustrate your answer with a plot
data=flights |> 
  group_by(hour) |> 
  summarize(dep_del=sum(dep_delay, na.rm = T),arr_del=sum(arr_delay, na.rm = T))
data|>
  ggplot(aes(x=hour))+
  geom_line(aes(y=dep_del, color="red"))+
  geom_line(aes(y=arr_del,color="blue"))
  
# What happens if you supply a negative n to slice_min() and friends?
flights|>
slice_min(flight,n=-1)
# Explain what count() does in terms of the dplyr verbs you just learned. What does the sort argument to count() do?
flights|>
  count(carrier,sort = T)
flights|>
  group_by(carrier)|>
  summarise(n(),sort=T)
# Suppose we have the following tiny data frame:
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)
# Write down what you think the output will look like, then check if you were correct, and describe what group_by() does.
df|>
  group_by(y)

# Write down what you think the output will look like, then check if you were correct, and describe what arrange() does. Also comment on how it’s different from the group_by() in part (a)?
df |>
  arrange(y)
# Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does.
df |>
  group_by(y) |>
  summarize(mean_x = mean(x))
# Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does. Then, comment on what the message says
df |>
  group_by(y,z)|>
  summarise(mean_x=mean(x))

# Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does. How is the output different from the one in part (d).
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")
# Write down what you think the outputs will look like, then check if you were correct, and describe what each pipeline does. How are the outputs of the two pipelines different?

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))


install.packages("Lahman")
library(Lahman)
batters <- Lahman::Batting |> 
  group_by(playerID) |> 
  summarize(
    performance = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    n = sum(AB, na.rm = TRUE)
  )
batters