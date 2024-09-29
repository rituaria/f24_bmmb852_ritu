# Week 5: Simulating FASTQ files

Questions were obtained from the Canvas assignment, not the class website, for consistency.

### Part 1
#### 1. Select a genome, then download the corresponding FASTA file.

I selected the genome for *Genlisea aurea*, a carnivorous plant with one of the smallest known plant genomes. Accession: GCA_000441915.1, https://www.ncbi.nlm.nih.gov/datasets/taxonomy/192259/ 

- **The size of the file:** 43MB
- **The total size of the genome:** 43,357,795
- **The number of chromosomes in the genome:** This genome does not have assembled chromosomes. Noting the number of contiguous DNA sequences is 10,684 instead. 
- **The name (id) and length of each chromosome in the genome:** No assembled chromosomes, but average contig length is in the seqkit summary as 4058.2 bases. If I were to try to find this information in another organism I would use seqkit faidx to obtain this information from the index file or fx2tab to output name and length. Did faidx and got a file that has the desired information for the contigs in col 1 and 2, see below for detailed steps. 

Code and output for part 1:

```bash
bio fetch GCA_000441915.1 -format fasta > temp.fasta
ls -l
```
gives file size of 43M.

```bash
seqkit stats temp.fasta
```

returns:

```
file  format  type  num_seqs     sum_len  min_len  avg_len  max_len
-     FASTA   DNA     10,684  43,357,795      791  4,058.2  169,254
```


```bash
seqkit faidx temp.fasta
head temp.fasta.fai
```

returns:

```
KE526703.1      9407    94      80      81
KE526704.1      98263   9713    80      81
KE526705.1      8528    109299  80      81
KE526706.1      2279    118028  80      81
KE526707.1      3069    120430  80      81
KE526708.1      1151    123632  80      81
KE526709.1      7102    124892  80      81
KE526710.1      50435   132177  80      81
KE526711.1      169254  183337  80      81
KE526712.1      1602    354802  80      81
```
where Col 1 is the ID, Col 2 is the length of each sequence. 


### Part 2
#### 2. Generate a simulated FASTQ output for a sequencing instrument of your choice.  Set the parameters so that your target coverage is 10x. 


- **How many reads have you generated?** 215000
- **What is the average read length?** 100
- **How big are the FASTQ files?** 50MB each
- **Compress the files and report how much space that saves.** Zipping gives 9.0MB each, which saves 41MB each.

**Discuss whether you could get the same coverage with different parameter settings (read length vs. read number).**
You can get similar coverage with different parameter settings, for example, halfing the number of reads and doubling the read length, but it is not exactly the same when I tested it, probably due to how wgsim handles the actual simulation based on number of sequences. 

Code and output for part 2:

```bash
datasets download genome accession GCA_000441915.1
unzip -o ncbi_dataset.zip
ln -sf ncbi_dataset/data/GCA_000441915.1/GCA_000441915.1_GenAur_1.0_genomic.fna genaur.fa
mkdir simmedseqs
# to set parameters as 10X for 100 length read and a 43.4 million base genome, setting N as 215000, aka half of 
wgsim -N 215000 -1 100 -2 100 -r 0 -R 0 -X 0 genaur.fa simmedseqs/reads1.fq simmedseqs/reads2.fq
seqkit stats simmedseqs/reads1.fq simmedseqs/reads2.fq
```

returns:

```
file                  format  type  num_seqs     sum_len  min_len  avg_len  max_len
simmedseqs/reads1.fq  FASTQ   DNA    214,904  21,490,400      100      100      100
simmedseqs/reads2.fq  FASTQ   DNA    214,904  21,490,400      100      100      100
```

```bash
gzip simmedseqs/reads1.fq
ls -l simmedseqs/
```


### Part 3
#### 3. How much data would be generated when covering the Yeast,  the Drosophila or the Human genome at 30x?

Now imagine that instead of your genome, each instrument generated reads that cover the Yeast, Drosophila, and Human genomes at 30x coverage (separate runs for each organism). You don't have to run the tool all you need is to estimate.
Using the information you've obtained in the previous points, for each of the organisms, estimate the size of the FASTA file that holds the genome, the number of FASTQ reads needed for 30x, and the size of the FASTQ files before and after compression.

Assumptions:
- 100b length of reads
- total reads, if using this info for wgsim, the Reads for 30x C should be halved
- using the proportions from the info above

| Category           | Yeast   | Drosophila | Human    |
|--------------------|---------|------------|----------|
| Genome Size        | 12 Mbp  | 139.5 Mbp  | 3.08 Gbp |
| FASTA File Size    | 12MB    | 140MB      | 3.1GB    |
| Reads for 30x C    | 3.6 mil | 41.85 mil  | 924 mil  |
| Uncompressed FASTQ | 840MB   | 9.7GB      | 215GB    |
| Compressed FASTQ   | 151.2   | 1.75GB     | 38.7GB   |