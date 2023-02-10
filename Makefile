TARGET  = zero-sum

DIFFPRE = $(TARGET)-diff

BIBTOOL = bibtool
LTXDIFF	= latexdiff-vc
LD-OPTS = --flatten --force --git --graphics-markup=0 --math-markup=1
LATEXMK = latexmk
LM-OPTS	= -quiet -bibtex -f -pdf -pvctimeoutmins=90 -pdflatex="pdflatex -synctex=1 -interaction=nonstopmode" -use-make
LMCOPTS = -quiet -bibtex -C
LC-OPTS	= -bibtex -pdf -pdflatex="pdflatex -synctex=1 -interaction=nonstopmode" -use-make
RM      = rm -f
COPY    = cp
MAKE    = make
PANDOC	= pandoc

# pdf

all : pdf

pdf : $(TARGET).pdf

$(TARGET).pdf : $(TARGET).tex $(TARGET).bib
	$(LATEXMK) $(PREVIEW) $(LM-OPTS) $(TARGET).tex

check:
	$(LATEXMK) $(PREVIEW) $(LC-OPTS) $(TARGET).tex

view: PREVIEW=-pvc
view:
	$(LATEXMK) $(PREVIEW) $(LM-OPTS) $(TARGET).tex

# latexdiff
# Usage: make diff O=rev1 N=rev2

ifeq ($(strip $(N)),)
N = HEAD
endif
NEWGITR = $(shell git rev-parse $(N) | cut -c1-8)

ifeq ($(strip $(O)),)
O = $(NEWGITR)^
endif
OLDGITR = $(shell git rev-parse $(O) | cut -c1-8)

GITREVS = -r $(OLDGITR) -r $(NEWGITR)
DIFFILE = $(DIFFPRE)$(OLDGITR)-$(NEWGITR)

$(DIFFILE).pdf :
	$(LTXDIFF) $(LD-OPTS) $(GITREVS) $(TARGET).tex
	$(LATEXMK) $(PREVIEW) $(LM-OPTS) $(DIFFILE).tex

diff: PREVIEW=-pv
diff: $(DIFFILE).pdf

docx:
	$(PANDOC) $(TARGET).tex --bibliography $(TARGET).bib --citeproc -o $(TARGET).docx

# clean

clean:
	@$(LATEXMK) $(LMCOPTS)
	@$(RM) $(TARGET).ent $(TARGET).brf

diffclean:
	@$(RM) -r $(DIFFPRE)*

distclean: clean diffclean
	@$(RM) -r auto

.PHONY: view clean distclean diffclean
