set -eux
cp ../pandora1_paper_analysis_output_20_way/illumina_analysis/FP_genes/pandora_illumina_100x_withdenovo/gene_classification_by_gene_length.png gene_classification_by_gene_length.illumina.png
cp ../pandora1_paper_analysis_output_20_way/illumina_analysis/FP_genes/pandora_illumina_100x_withdenovo/gene_classification_by_gene_length_normalised.png gene_classification_by_gene_length_normalised.illumina.png
cp ../pandora1_paper_analysis_output_20_way/nanopore_analysis/FP_genes/pandora_nanopore_100x_withdenovo/gene_classification_by_gene_length.png gene_classification_by_gene_length.nanopore.png
cp ../pandora1_paper_analysis_output_20_way/nanopore_analysis/FP_genes/pandora_nanopore_100x_withdenovo/gene_classification_by_gene_length_normalised.png gene_classification_by_gene_length_normalised.nanopore.png
Rscript gene_classification.R