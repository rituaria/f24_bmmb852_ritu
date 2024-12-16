# Week 14: Perform a differential expression analysis
Your submission should include a readme, a makefile, and a design file.
You may re-use code and genomes from your previous submission.
Perform a differential expression analysis of a count matrix.

1. Take a count matrix, this count matrix may be one generated in a previous assignment or one that simulated. Use method to identify genes/transcripts that show differential expression.

2. Draw a PCA plot and a heatmap for these genes.

3. Discuss the results. How many genes have you found. What kind of expression levels can you observe. How reliable does your data seem?



#### Step 1: Find differential expression from a count matrix
I pulled 300000 reads from each SRR instead of 100000 to hopefully get a count matrix that has higher coverage of the data. I made a target to find differentially expressed genes using `edger` from the bioinformatics toolbox in the `stats` environment. The tool refused to accept my `counts.txt`, seems it only wanted a csv. I converted and updated the information but it still required more troubleshooting (something off with the data frame?). This was really frustrating, as I was excited to look at real data, however I switched to simulating data which was successful.

#### Step 2: Make PCA plot and heatmap

I made the target `visualize` to generate the PCA and heatmap using the toolbox.
![pca.pdf](pca.pdf)

![heatmap.pdf](heatmap.pdf)


#### Step 3: Discussion
Part of the output from Step 1 showed the number of genes found to be statistically significantly differentially expressed was 134:

```
# Significant PVal:  388 ( 8.30 %)
# Significant FDRs:  147 ( 3.10 %)
# Results: edger.csv
# Tool: evaluate_results.r
# 241 in counts.csv
# 147 in edger.csv
# 134 found in both
# 107 found only in counts.csv
# 13 found only in edger.csv
```

The number of genes found different seems pretty low but not too low (<50). Frankly I'm disappointed I couldn't make this work with some real data yet, as I may have more to think and say about then. But with the gene ID workaround for the GFF file and the genes not being annotated in that could matrix either, I don't know if that would have been useful at all either... I need to figure this out to re-analyze some lab transcriptomic data as well, but wanted to ensure I practiced working with the tools and improving my understanding a bit. 