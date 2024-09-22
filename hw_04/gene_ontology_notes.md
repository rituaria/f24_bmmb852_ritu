# Exploring a sequence ontology

Using the script I made (also in this directory) ncbi_gff_features.sh, the *Prunus dulcis* (almond) feature list shows:

```
253966  exon
210915  CDS
33326   mRNA
25445   gene
1875    lnc_RNA
1687    transcript
1493    pseudogene
1181    cDNA_match
692     region
474     tRNA
335     snoRNA
103     snRNA
46      rRNA
```

From this I was curious what the SO definition of snoRNA is. Based on my understanding it is small nucleolar RNA that helps modify things like ribosomal RNA and tRNA. 

Running:

```bash
bio explain snoRNA
```

prints:


```
GO:0000452  snorna guided rrna 2'-o-methylation
GO:0000454  snorna guided rrna pseudouridine synthesis
GO:0001014  snorna transcription by rna polymerase iii
GO:0001015  snorna transcription by rna polymerase ii
GO:0030515  snorna binding
GO:0031070  intronic snorna processing
GO:0034247  snorna splicing
GO:0034511  u3 snorna binding
GO:0034513  box h/aca snorna binding
GO:0034966  intronic box h/aca snorna processing
GO:0048254  snorna localization
GO:0071036  nuclear polyadenylation-dependent snorna catabolic process
GO:0071051  polyadenylation-dependent snorna 3'-end processing
GO:1902796  regulation of snorna processing
GO:1902797  negative regulation of snorna processing
GO:1902798  positive regulation of snorna processing
GO:1903323  regulation of snorna metabolic process
GO:1903324  negative regulation of snorna metabolic process
GO:1903325  positive regulation of snorna metabolic process
GO:1990417  snorna release from pre-rrna
SO:0000232  snorna_primary_transcript
SO:0000275  snorna
SO:0000403  u14_snorna
SO:0000578  snorna_encoding
SO:0000580  methylation_guide_snorna_primary_transcript
SO:0000582  rrna_cleavage_snorna_primary_transcript
SO:0000585  c_d_box_snorna_encoding
SO:0000593  c_d_box_snorna
SO:0000594  h_aca_box_snorna
SO:0000595  c_d_box_snorna_primary_transcript
SO:0000596  h_aca_box_snorna_primary_transcript
SO:0000608  h_aca_box_snorna_encoding
SO:0001179  u3_snorna
SO:0001187  pseudouridylation_guide_snorna
SO:0001267  snorna_gene
SO:0002034  mir_encoding_snorna_primary_transcript
SO:0005837  u14_snorna_primary_transcript
SO:0005841  methylation_guide_snorna
```

This is a list of all gene and sequence ontology terms that have snoRNA in them, and it seems to not be case-sensitive. According to the sequence ontology website (http://www.sequenceontology.org/browser/current_release/term/SO:0000275), the parents of snoRNA are sncRNA and snoRNA_primary_transcript. The children are scaRNA, C_D_box_snoRNA, and H_ACA_box_snoRNA. 

![snoRNA nodes] (hw4_images/SNORNA_NodesGraph.png)
