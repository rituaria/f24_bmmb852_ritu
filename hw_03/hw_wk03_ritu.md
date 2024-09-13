# Week 3: Download, Generate and Visualize GFF files in IGV

## Visualize the GFF file of your choice.

### Using a resource of your choice, download the genome and annotation files for an organism of your choice.(We recommend a smaller genome to make things go faster and to look at a simpler GFF file)
GCF_000346465.2 refers to the reference genome of *Prunus persica*, common name peach.

https://plants.ensembl.org/Prunus_persica/Info/Index
https://www.ebi.ac.uk/ena/browser/view/GCA_000346465.2
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
    cat genomic.gff | awk '$3 == "gene"' > gene.gff
```