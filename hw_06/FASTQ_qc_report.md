# Week 6: FASTQ Quality Control

Write a script that downloads data from the SRA Links to an external site. or ENA

Links to an external site. database and performs a quality control analysis on the data.

When searching for data use the genome you selected for the read simulation assignment as the target organism. Select Illumina or Iontorrent instruments only.

Identify a bad sequencing dataset. You may need to evaluate multiple SRR numbers to find one with poor quality.

1. Use data generated on the Illumina or Iontorrent platforms.
2. Write a script to download data from the SRA database.
3. Evaluate the quality of the downloaded data.
4. Improve the quality of the reads in the dataset.
5. Evaluate the quality again and document the improvements.

Your script should include all necessary code. The markdown report should explain the data and publication it corresponds to and present the results of your analysis.

Commit the two files to your repository and submit the link to the folder containing the files.

Tip: Older datasets are often of lower quality the sequencing instruments were less reliable in the past.

__________________________
I previously selected the genome for *Genlisea aurea*, a carnivorous plant with one of the smallest known plant genomes. It only has two SRR datasets, the difference being the size of the library. I picked https://www.ncbi.nlm.nih.gov/sra/SRX312272[accn] the SRA with a 413 bp library based on an initial check of the fastqc graphs. The SRR is SRR916071. The dataset is from the below publication: 

Leushkin, E. V., Sutormin, R. A., Nabieva, E. R., Penin, A. A., Kondrashov, A. S., & Logacheva, M. D. (2013). The miniature genome of a carnivorous plant Genlisea aurea contains a low number of genes and short non-coding sequences. BMC Genomics, 14, 476. https://doi.org/10.1186/1471-2164-14-476

The paper sought to de novo sequence the genome of this organism and determined when comparing it to another member in the same clade, a massive reduction in non-coding sequences and loss of many genes.

I am unsure if this dataset is considered particularly good or bad off the bat. Upon running:

```bash
# Download a sample of reads in a separate folder
fastq-dump -X 1000 -F --outdir reads --split-files SRR916071
# Run fastqc on both files of the paired end reads
fastqc -o reports reads/SRR916071_1.fastq reads/SRR916071_2.fastq
```
and opening the html files generated shows:

![]()

![]()

I utilized https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/ to help make some interpretations of the QC. Overall, the distribution doesn't seem to fit the bad quality data examples seen here and in class, so maybe there is something else going on. The two sets of files seem to have different qualities! These should be paired but because they are coming from different ends, maybe the quality of the sequencing for one direction was greatly improved over the other somehow? Some additional observations: 

For the first file:

1. The beginning and end of the reads both have pretty low scores. In fact the beginning seems abysmal, base 5 to 25 or so averages a score well below 30. 
2. Per sequence quality score, aka phred score, has peaks in the middle of the reads, at base 10 and bases 26-27. There is no warning for this, but the documentation says that it is a more robust module and will not give one unless the run quality is really really bad. Still, it could potentially indicate moderately poor quality run for that direction. 
3. The per-sequence GC content does not fit the theoretical curve, and the per base sequence content failed due to disparities early in the reads. This could be the reason for the Per base N content failure as well. The analysis module states "Such deviations can occur when you have very biased sequence composition in the library to the point that base callers can become confused and make poor calls. This type of problem will be apparent when looking at the per-base sequence content results."
4. There is a warning for overrepresented sequences in both files (they are different), but this may just be because the libararies were too small and that makes that more likely according the the analysis module. It does not seem to be excessive. 

I attempted to clean up the data with a blunt method at the risk of overfitting using these commands:

```bash
fastp --cut_right -i reads/SRR916071_1.fastq -o reads/SRR916071_1.trimmed.fastq -I reads/SRR916071_2.fastq -O reads/SRR916071_2.trimmed.fastq
fastqc -o reports reads/SRR916071_1.trimmed.fastq reads/SRR916071_2.trimmed.fastq
```

![]()

From the original 1000 sampled sequences it kept 465 of them, less than half. Some of them were trimmed to 17 bases in length! The percent GC content is the same as before, still 41. Overall all the flags have gone down to warnings except the Per base sequence content which still shows a high disparity in the first few bases. The number of overrepresented sequences increased a lot too, maybe because the source being checked is even smaller now. 