install:
	R CMD INSTALL .
develop:
	tmux split-window -v -c "#{pane_current_path}" 'R' && \
	tmux send-keys "devtools::load_all('.')" Enter
doc:
	rm -rf NAMESPACE
	Rscript -e "devtools::document(roclets = c('rd', 'collate', 'namespace'))"
test:
	Rscript -e 'devtools::test()'
test-continuous:
	find R/ tests/testthat/ -type f -name "*.R" | entr make test
