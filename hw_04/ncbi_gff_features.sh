set -uex

# You must activate the environment as below without the "#"
# micromamba activate bioinfo

# The NCBI accession for the desired species ${REFSEQID}
REFSEQID="GCF_902201215.1"


# Variable prefix for a temporary directory
NEWDIR="temp"


# ----------- DO NOT CHANGE BELOW THIS LINE -------------

# Make and go to new directory to download and work into
mkdir -p ${NEWDIR}_${REFSEQID}
cd ${NEWDIR}_${REFSEQID}

# Use NCBI's downloader to obtain GFF file
datasets download genome accession ${REFSEQID} --include gff3

# Unzip file, name is set by NCBI
unzip ncbi_dataset.zip

# Enter unzipped directory
cd ncbi_dataset/data/${REFSEQID}

# Read GFF features column without # lines
cat genomic.gff |cut -f 3 | grep -v '#' > feature_types.txt

# Read feature_types.txt and output a sorted ranked list of number and type of features
cat feature_types.txt | sort-uniq-count-rank

# Navigate back to initial working directory
cd ../../../../

# Remove all temp files
rm -rf ${NEWDIR}_${REFSEQID}