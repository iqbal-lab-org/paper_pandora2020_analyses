set -eux
Rscript generate_tool_palette.R
python preprocess_20_way_illumina_ROC.py
python preprocess_20_way_nanopore_ROC.py
python preprocess_precision_per_sample.py
Rscript Figure6.R