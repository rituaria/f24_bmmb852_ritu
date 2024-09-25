set -uex
# READ BELOW
# You must activate the bioinfo environment as below without the initial "#"
# micromamba activate bioinfo
# You must have the  NCBI command-line tools downloaded https://www.ncbi.nlm.nih.gov/datasets/docs/v2/reference-docs/command-line/datasets/ 


# Input the NCBI accession for the desired species within the quotes
REFSEQID="GCF_902201215.1"


# Variable prefix for a temporary directory
NEWDIR="temp"


# ----------- DO NOT CHANGE BELOW THIS LINE -------------

# This file was edited with suggestions from class

# Make and go to new directory to download and work into -- unnecessary, just assume that the user is putting the script correctly in whatever directory it is being run
# mkdir -p ${NEWDIR}_${REFSEQID}
# cd ${NEWDIR}_${REFSEQID}

# Use NCBI's downloader to obtain GFF file
datasets download genome accession ${REFSEQID} --include gff3

# Unzip file, name is set by NCBI, -o is for overwriting anything for the rerun without asking
unzip -o ncbi_dataset.zip

# Enter unzipped directory
#cd ncbi_dataset/data/${REFSEQID}

# Read GFF features column without # lines
cat ncbi_dataset/data/${REFSEQID}/genomic.gff |cut -f 3 | grep -v '#' > feature_types.txt

# Read feature_types.txt and output a sorted ranked list of number and type of features
cat feature_types.txt | sort-uniq-count-rank

# Navigate back to initial working directory -- this is dangerous, don't do this, can be easily accidentally changed
# cd ../../../../

# Remove all temp files -- dont do this either
# rm -rf ${NEWDIR}_${REFSEQID}