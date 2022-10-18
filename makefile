# main build rule

all: gen/output/plot_Antwerp.pdf gen/output/plot_all.pdf

# sub builds
data/reviews.csv data/listings.csv: src/data-prep/download.R
		R --vanilla < src/data-prep/download.R

gen/temp/aggregated_df.csv: src/data-prep/clean.R data/reviews.csv data/listings.csv
		R --vanilla < src/data-prep/clean.R
		
		
gen/temp/pivot_table.csv: gen/temp/aggregated_df.csv src/analysis/pivot_table.R
		R --vanilla < src/analysis/pivot_table.R
		
gen/output/plot_Antwerp.pdf: gen/temp/pivot_table.csv src/analysis/plot_Antwerp.R
		R --vanilla < src/analysis/plot_Antwerp.R
		
gen/output/plot_all.pdf: gen/temp/aggregated_df.csv src/analysis/plot_all.R
		R --vanilla < src/analysis/plot_all.R
		
clean:
	R -e "unlink('*.pdf')"
	R -e "unlink('*.csv')"