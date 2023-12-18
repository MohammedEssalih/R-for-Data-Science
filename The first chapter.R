install.packages("palmerpenguins")
install.packages("ggthemes")
library(tidyverse)
library(palmerpenguins)
library(ggthemes)
palmerpenguins::penguins
View(penguins)

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)+
  geom_point(mapping = aes(color=species))+
  geom_smooth(method="lm")


ggplot(data = penguins, mapping=aes(x=flipper_length_mm,y=body_mass_g)) + 
  geom_point(mapping = aes(color=bill_depth_mm), na.rm=T)+
  labs(title = "Data come from the palmerpenguins package", 
       subtitle = "Try from R for data Science book", x= "the lenght of the fipper",
       y="The mass of the penguin's body")+
  geom_smooth(se=F, na.rm=T)
  
ggplot(penguins,aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

penguins |> 
  ggplot(aes(x=body_mass_g))+
  geom_histogram(na.rm=T, binwidth = 200)

penguins |> 
  ggplot(aes(y=species))+
  geom_bar(na.rm=T)

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(diamonds, aes(x = carat)) +
  geom_density( fill = "red")


# 1.5 Visualizing relationships

ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 1.75)

ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.6)

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()
# 1.5.3 Two numerical variables
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color=species))+
  facet_wrap(~island)
# 1.5.5 Exercises
?mpg
View(mpg)
mpg|>
  ggplot(aes(y=displ,x=hwy))+
  geom_point(aes(alpha=1.6))+
  facet_wrap(~cyl)

penguins|>
  ggplot(aes(y=bill_length_mm,x=bill_depth_mm, color=species))+
  geom_point()
  #facet_wrap(~cyl)

#6
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() 

#8
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")
ggsave(filename = "Try.png")

#1.6 Saving your plots

ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.png")

#1.7 Common problems

primes <- c(2, 3, 5, 7, 11, 13)
mean(primes^2)-mean(primes)^2-var(primes)

x=12
this_is_a_really_long_name <- 2.5
this