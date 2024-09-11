# Week 2: Demonstrate data analysis at UNIX command line

### Select an organism and download its corresponding GFF file.
```bash
mkdir -p hw_wk02
cd hw_wk02
wget http://ftp.ensembl.org/pub/current_gff3/athene_cunicularia/Athene_cunicularia.athCun1.112.gff3.gz
gunzip Athene_cunicularia.athCun1.112.gff3.gz
```

I accidentally downloaded the ab initio file at first, whoops! That's not the feature annotated file, that's an annotation input I assume. 


### Investigate this file with command line UNIX tools.
```bash
#parsing the features bit by bit
cat Athene_cunicularia.athCun1.112.gff3 | cut -f 3 | sort-uniq-count-rank | more

#to figure out how to not include lines starting with # or ##
man grep 

#Make a file with all of column 3 that is relevant (aka no commented or metadata lines)
cat Athene_cunicularia.athCun1.112.gff3 | cut -f 3 | grep -v '#' > feature_types.txt

```


### Find answers to the following questions:

#### Tell us a bit about the organism. 

Athene cunicularia is also known as the burrowing owl, taxon ID 194338. Some information about the annotation built:
```bash
cat Athene_cunicularia.athCun1.112.gff3 | grep '#' | grep -v '##'
```
prints:
```
#!genome-build  athCun1
#!genome-version athCun1
#!genome-date 2018-06
#!genome-build-accession GCA_003259725.1
#!genebuild-last-updated 2019-09
```

#### How many features does the file contain? 693945
```bash
cat feature_types.txt | wc -l
```
#### How many sequence regions (chromosomes) does the file contain? 445
```bash
cat Athene_cunicularia.athCun1.112.gff3 | grep '##s'| wc -l
```

#### How many genes are listed for this organism? 13835
```bash
cat feature_types.txt | sort-uniq-count-rank
```
prints (determine gene number from here):
```
308274  exon
299787  CDS
22665   mRNA
18929   biological_region
14322   five_prime_UTR
13835   gene
13156   three_prime_UTR
1153    ncRNA_gene
921     lnc_RNA
445     region
173     snoRNA
110     miRNA
61      pseudogene
61      pseudogenic_transcript
30      snRNA
14      scRNA
4       transcript
3       Y_RNA
2       rRNA
```


#### What are the top-ten most annotated feature types (column 3) across the genome?
```bash
cat feature_types.txt | sort-uniq-count-rank |head
```
prints:
```
308274  exon
299787  CDS
22665   mRNA
18929   biological_region
14322   five_prime_UTR
13835   gene
13156   three_prime_UTR
1153    ncRNA_gene
921     lnc_RNA
445     region
```



#### Having analyzed this GFF file, does it seem like a complete and well-annotated organism?

I am unsure what makes a complete and well-annotated organism... There are tools like BUSCO and GenomeQC that can analyze an assembly quality in general or against a reference genome. From my reading this is annotated, sure, but I don't know if well enough to have robust results for further genomic analysis.

#### Share any other insights you might note.

Parsing files solely via the terminal or in an automated fashion requires a lot of care into how you grep the specific information you need. Example being the number of genes question, there may be instances where you want to include pseudogenes or figure out what a feature called noncoding RNA genes is. The question you are trying to answer needs to be clear and paired with an understanding that labels and categories are human imposed, biology is complex. It is helpful to understand the parameters and information provided in the file you are working with.

### Create a text file that shows both how you downloaded the data and how you generated each of your results.

### Commit the file to your GitHub repository that you created for this course.