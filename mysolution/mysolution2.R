#!/usr/bin/env Rscript

# Różnica między grafami Barabási-Albert i Erdős-Rényi:
# - Barabási-Albert: model preferential attachment, nowe węzły łączą się z większym 
#   prawdopodobieństwem z węzłami o wysokim stopniu, tworzy sieci bezskalne z rozkładem
#   stopni potęgowym, charakterystyczne dla rzeczywistych sieci społecznych/technicznych
# - Erdős-Rényi: model losowy, każda para węzłów ma jednakowe prawdopodobieństwo połączenia,
#   tworzy sieci z rozkładem stopni zbliżonym do Poissona, bardziej jednorodne

library(igraph)

set.seed(42)

ba_graph <- sample_pa(n = 1000, power = 1, m = 2, directed = FALSE)

layout_fr <- layout_with_fr(ba_graph)

pdf("Rplots.pdf")
plot(ba_graph, 
     layout = layout_fr,
     vertex.size = 3,
     vertex.label = NA,
     edge.arrow.size = 0.2,
     main = "Graf Barabási-Albert (1000 węzłów) - Layout Fruchterman & Reingold")
dev.off()

betweenness_vals <- betweenness(ba_graph)

most_central_node <- which.max(betweenness_vals)
max_betweenness <- max(betweenness_vals)

graph_diameter <- diameter(ba_graph)

cat("Najbardziej centralny węzeł według betweenness centrality:", most_central_node, "\n") # ma numer 6
cat("Wartość betweenness centrality:", max_betweenness, "\n") # 79059.61
cat("srednica grafu:", graph_diameter, "\n") # 8
