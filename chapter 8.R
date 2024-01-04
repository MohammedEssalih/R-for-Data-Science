# Left
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, color = class))+
  geom_smooth(y)
#> Warning: Using size for a discrete variable is not advised.

# Right
ggplot(mpg, aes(x = displ, y = hwy, alpha = class)) +
  geom_point()
#> Warning: Using alpha for a discrete variable is not advised.
ggplot(mpg) + 
geom_point(aes(x = displ, y = hwy, color = displ < 5))



# Left
ggplot(mpg, aes(x = displ, y = hwy, shape = drv)) + 
  geom_smooth()

# Right
ggplot(mpg, aes(x = displ, y = hwy, linetype = drv)) + 
  geom_smooth()
