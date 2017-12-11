
read.csv(file.choose())
stats <- read.csv(file.choose())
stats
head(stats)
str(stats)
runif(stats)
rnorm(stats)
stats$Internet.users
stats$Internet.users[2]
stats[,1]


# Filtering

filter <- stats$Internet.users < 2
stats[filter,]

stats[stats$Birth.rate < 40,]
stats[stats$Birth.rate > 40 & stats$Internet.users < 2,]
stats[stats$Income.Group == "High income",]
levels(stats$Country.Name)
stats[stats$Country.Name == "Malta",]

# qplot()
library(ggplot2)
?qplot
qplot(data=stats, x=Internet.users)
qplot(data=stats, x=Income.Group, y=Birth.rate)
qplot(data=stats, x=Income.Group, y=Birth.rate, col=I(4), size=I(3))
qplot(data=stats, x=Income.Group, y=Birth.rate, geom = "boxplot")

qplot(data = stats, x=Internet.users, y=Birth.rate, size=I(4), color=I("red"))

qplot(data = stats, x=Internet.users, y=Birth.rate, size=I(5), color=Income.Group)

# Creating Data Frames

mydf <- data.frame(Countries_2012_Dataset, Codes_2012_Dataset,
                   Regions_2012_Dataset)
#head(mydf)
#colnames(mydf) <- c("Country", "Code", "Region")
rm(mydf)

mydf <- data.frame(Counry=Countries_2012_Dataset, Code=Codes_2012_Dataset, Region=Regions_2012_Dataset)
head(mydf)

tail(mydf)
summary(mydf)

# Merging Data Frames
head(mydf)
tail(mydf)

merged <- merge(stats, mydf, by.x = "Country.Code", by.y = "Code")
head(merged)

merged$Country <- NULL
str(merged)
tail(merged)

# Visualizing with new Split

qplot(data=merged, x=Internet.users, y=Birth.rate)
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region)
# Shapes
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region, size=I(5), shape=I(2))
# Transparency
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region, size=I(5), shape=I(19),
      alpha=I(0.6))
# Title
qplot(data=merged, x=Internet.users, y=Birth.rate,
      col=Region, size=I(5), shape=I(19),
      alpha=I(0.6),
      main="Birth Rate vs Internet Users")




