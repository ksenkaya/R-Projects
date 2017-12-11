getwd()
movies <- read.csv(file.choose())

head(movies)
colnames(movies) <- c("Film", "Genre","CriticRating","AudienceRating","BudgetMillions","Year")
head(movies)
tail(movies)
str(movies)
summary(movies)

factor(movies$Year)
movies$Year <- factor(movies$Year)
summary(movies)
str(movies)

#-------- Aesthetics

library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) +
  geom_point()

# add color
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                        col=Genre)) +
  geom_point()

#add size
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                        col=Genre, size=BudgetMillions)) +
  geom_point()

#>>> This #1 improvement


#------ Plotting with Layers
p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             col=Genre))
#point
p + geom_point()

#lines
p + geom_line()

#multiple layers
p + geom_point() + geom_line()
p + geom_line() + geom_point()

#------ Overriding Aesthetics
q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, col=Genre, size=BudgetMillions))
q + geom_point()
#ex1
q + geom_point(aes(size=CriticRating))

#ex2
q + geom_point(aes(col=BudgetMillions))

#q remains the same
q + geom_point()

#ex3
q + geom_point(aes(BudgetMillions)) +
  xlab("Budget Millions $$$")
#>>> 2nd Chart

#ex4
q + geom_line() + geom_point()

#reduce line size
q + geom_line(size=1) + geom_point()

#----------- Mapping vs Setting

r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()

#Add color
#1. Mapping 
r + geom_point(aes(col=Genre))
#2. Setting
r + geom_point(col="DarkRed")
#ERROR:
# r + geom_point(aes(col=6))

#1. Mapping
r + geom_point(aes(size=BudgetMillions))
#2. Setting
r + geom_point(size=10)
#ERROR:
# r + geom_point(aes(size=10))

#-------- Histograms and Density Charts
  
s <- ggplot(data=movies, aes(x=BudgetMillions))
s + geom_histogram(binwidth=10)

# add color
s + geom_histogram(binwidth=10, aes(fill=Genre))
# add a border
s + geom_histogram(binwidth=10, aes(fill=Genre), col="Black")
#>>> Chart3

#density charts
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position = "stack")

#----------- Starting Layer Tips

t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10,
               fill="White", col="Blue")

#another way
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10,
                   aes(x=AudienceRating),fill="White", col="Blue")

#>>> Chart4
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10,
                   aes(x=CriticRating),
                   fill="White", col="Blue")
#-------------- Statistical Transformations

u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             col=Genre))
u + geom_point() + geom_smooth(fill=NA)

#Boxplots
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating, col=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()
#tip
u + geom_boxplot(size=1.2) + geom_jitter()
#another way
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

#ex5
k <- ggplot(data = movies, aes(x=Genre, y=CriticRating, col=Genre))
k + geom_boxplot()
k + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

#------- FACETS

v <- ggplot(data=movies, aes(x=BudgetMillions))
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   col="Black")
#facets
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   col="Black") + 
  facet_grid(Genre~., scales="free")

#scatter plots
w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             col=Genre))
w + geom_point(size=3)

#facets
w + geom_point(size=3) +
  facet_grid(Genre~.)

w + geom_point(size=3) +
  facet_grid(.~Year)

w + geom_point(size=3) +
  facet_grid(Genre~Year)

w + geom_point(size=3) +
  geom_smooth() +
  facet_grid(Genre~Year)

w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year)

#------------- Coordinates

m <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, size=BudgetMillions, col=Genre))
m + geom_point()

#limits
m + geom_point() +
  xlim(50,100) +
  ylim(50,100)
#won't work well always
n <- ggplot(data=movies, aes(x=BudgetMillions))
n + geom_histogram(binwidth=10, aes(fill=Genre), col="Black")

n + geom_histogram(binwidth=10, aes(fill=Genre), col="Black") +
  ylim(0,50)

#instead - zoom:
n <- geom_histogram(binwidth=10, aes(fill=Genre), col="Black") +
  coord_cartesian(ylim = c(0,50))

# improve #1
w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year) +
  coord_cartesian(ylim = c(0,100))

#-------------- Theme
o <- ggplot(data=movies, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth=10, aes(fill=Genre), col="Black")

#axes labels
h + xlab("Money Axis") +
  ylab("Number of Movies")

#label formatting
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(color ="DarkGreen", size=30),
        axis.title.y=element_text(color ="Red", size=30))

#tick mark formatting
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(color ="DarkGreen", size=30),
        axis.title.y=element_text(color ="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))

#legend formatting
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(color ="DarkGreen", size=30),
        axis.title.y=element_text(color ="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size = 20),
        legend.position = c(1,1),
        legend.justification = c(1,1))

#title
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(color ="DarkGreen", size=30),
        axis.title.y=element_text(color ="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size = 20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(colour = "DarkBlue", size=40))


