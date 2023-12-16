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
  ggplot(aes(x=body_mass_g))+
  geom_density(na.rm=T, binwidth = 200)
