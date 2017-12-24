
crime_data <- read.csv(file.choose())

# Remove any NA values
crime0 <- na.omit(USArrests)

# Convert the data into a matrix
crime <- data.matrix (crime0)

# Analyzing the Clustering
str(crime)

# Set random seed
set.seed(1)

# Scale the dataset: crime_data_sc
crime_data_sc <- scale(crime)

# Perform k-means clustering: crime_km
crime_km <- kmeans(crime_data_sc, 4, nstart = 20)

# Perform single-linkage hierarchical clustering
## Calculate the distance matrix: dist_matrix
dist_matrix <- dist(crime_data_sc, method = "euclidean")

# Calculate the clusters using hclust(): crime_single
crime_single <- hclust(dist_matrix, method = "single")

# Cut the clusters using cutree: memb_single
memb_single <- cutree(crime_single, 4)

# Calculate the Dunn's index for both clusterings: dunn_km, dunn_single
dunn_km <- dunn(clusters = crime_km$cluster, Data = crime_data_sc)
dunn_single <- dunn(clusters = memb_single, Data = crime_data_sc)

# Print out the results
dunn_km
dunn_single
