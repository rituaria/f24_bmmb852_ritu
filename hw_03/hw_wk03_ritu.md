# Week 3: Download, Generate and Visualize GFF files in IGV

## Visualize the GFF file of your choice.

### Using a resource of your choice, download the genome and annotation files for an organism of your choice.(We recommend a smaller genome to make things go faster and to look at a simpler GFF file)

GCF_000346465.2 refers to the reference genome of *Prunus persica*, common name peach. Peaches are a member of the rose family *Rosaceae* and stonefruit genus *Prunus*, and are closely related to almonds *Prunus amygdalus*.

https://www.ncbi.nlm.nih.gov/datasets/taxonomy/3760/ 

#### Use IGV to visualize the annotations relative to the genome.

#### Separate intervals of type "gene" into a different file. If you don't have genes, pick another feature.

#### Manually generate a GFF that matches your genome. Load that GFF as a separate track in your view

### Report your findings in text, and provide a few relevant screenshots.

### You can attach the screenshots to CANVAS the assignment or even put them into the repository and link them into your markdown report.

### Your submission needs to list the link to the markdown file in your repository so that reviews can access it.

```bash
    mdir -p hw_wk03
    cd hw_wk03
    micromamba activate bioinfo
    datasets datasets download genome accession GCF_000346465.2 --include gff3,cds,protein,genome
    unzip ncbi_dataset.zip
    cd ncbi_dataset/data/GCF_000346465.2
```

Opened IGV on the Windows side, and opened the genomic assembly file "GCF_000346465.2_Prunus_persica_NCBIv2_genomic.fna" through "Genomes" > "Load Genome from File...". Then opened the genomic.gff from same filepath in explorer and dragged into window to see the provided annotation track Screenshot of the loaded genome annotation in IGV with all chromosomes. 

Screenshot1:
![screenshot1 loaded annotation](https://github.com/rituaria/f24_bmmb852_ritu/blob/main/hw_03/hw_03_1_loadedannotation.PNG)


Then to check the features in the gff file to determine what to extract I used:

```bash    
    cat genomic.gff |cut -f 3 | grep -v '#' | sort-uniq-count-rank

```

which prints:

```
235754  exon
194725  CDS
32595   mRNA
25030   gene
2102    lnc_RNA
1519    transcript
1384    pseudogene
1077    cDNA_match
453     tRNA
192     region
8       match
8       rRNA
```

There are plenty of genes listed so extracted them to new file as below, and dragged and dropped into the genome viewer window.

```bash
    #extracting lines annotated as "gene"
    cat genomic.gff | awk '$3 == "gene"' > gene.gff
```

As I scrolled through the viewer, I found that location of gene data was preserved in the "gene.gff" data file I made. Additionally, tRNA encoding regions were also preserved as under the gene category by this extraction, which is accurate categorization. 

Screenshot2:





Annotation such as what seems like homology-based predictions of genes for the same "LOC" were in the mRNA or exon features under "**product**", and not information provided in the gene data. 

Screenshot3:




Manually making a GFF file