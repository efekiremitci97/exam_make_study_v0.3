# main build rule

all: plot_Antwerp.pdf plot_all.pdf

# sub builds
reviews.csv listings.csv: download.R
		R --vanilla < download.R

aggregated_df.csv: clean.R reviews.csv listings.csv
		R --vanilla < clean.R
		
		
pivot_table.csv: aggregated_df.csv pivot_table.R
		R --vanilla < pivot_table.R
		
plot_Antwerp.pdf: pivot_table.csv plot_Antwerp.R
		R --vanilla < plot_Antwerp.R
		
plot_all.pdf: aggregated_df.csv plot_all.R
		R --vanilla < plot_all.R
		
clean:
	R -e "unlink('*.pdf')"
	R -e "unlink('*.csv')"