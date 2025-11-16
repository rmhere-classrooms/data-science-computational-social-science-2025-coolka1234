library(igraph)
library(ggplot2)

set.seed(123)

g <- sample_gnp(100, 0.05)

print("Initial Summary")
print(summary(g))
# na początku U-- czyli unweighted
V(g)
E(g)

E(g)$weight <- runif(ecount(g), min = 0.01, max = 1)

print("Summary")
print(summary(g))
# teraz W-- weighted

degrees <- degree(g)
print(degrees)

hist_data <- data.frame(degree = degrees)
p <- ggplot(hist_data, aes(x = degree)) +
  geom_histogram(binwidth = 1, fill = "lightblue", color = "black") +
  labs(title = "Histogram stopni wezlow", x = "Stopien", y = "Czestotliwosc") +
  theme_minimal()
print(p)

num_components <- components(g)$no
print(paste("Liczba klastrow (connected components):", num_components))

pagerank_scores <- page_rank(g)$vector
node_sizes <- pagerank_scores * 1000

plot(g, 
     vertex.size = node_sizes,
     vertex.label = NA,
     edge.width = 0.5,
     main = "Graf z rozmiarem wezlow wedlug PageRank")
