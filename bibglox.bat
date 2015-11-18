:: Erstellt von Erhan Tuna mit Hilfe von http://www.plexdata.de/fomsdt/samples/diploma_sample.html
:: Version: 1.03 optionaler bool Parameter %2 ob pdf gestartet werden soll
:: Version: 1.02
:: Diese Datei am besten über die PATH-Variable Systemweit bekannt machen
:: Parameter.count = 1, Beschreibung: zu kompilierende Hauptdatei.tex (ohne Endung!)
:: Kompilierreihenfolge ist wichtig und aus der Diplomarbeit abgeleitet

echo -------------------------------
echo BIBGLOX.BAT in der Version 1.03
echo (c) Erhan Tuna - 2015-11-15
echo -------------------------------

@echo off
:: %1 ist Hauptdatei ohne Endung
:: 1. Kompilieren der Hauptdatei => 
pdflatex -max-print-line=1256 -error-line=1256 -half-error-line=1236 -interaction=nonstopmode -enable-installer "%1"

:: 2. Abkürzungsverzeichnis erstellen
makeindex "%1".nlo -s nomencl.ist -o "%1".nls

:: 3. Literaturverzeichnis erstellen
bibtex "%1"

:: 4. Glossar erstellen
bibtex "%1".gls
pdflatex -max-print-line=1256 -error-line=1256 -half-error-line=1236 -interaction=nonstopmode -enable-installer "%1"
bibtex "%1".gls

:: 5. Index erstellen -g -s = nach ISO Standard (Bei Darstellungsproblemen mit Umlauten bitte nachfolgende Kompilierungsmethoden probieren)
::makeindex "%1".idx -g -s fomidx.ist
::makeindex "%1".idx -g -s "%1".ist
makeindex "%1".idx

:: 6. Finales Kompilieren um offen Referenzen zu ergänzen
pdflatex -max-print-line=1256 -error-line=1256 -half-error-line=1236 -interaction=nonstopmode -enable-installer "%1"
pdflatex -max-print-line=1256 -error-line=1256 -half-error-line=1236 -interaction=nonstopmode -enable-installer "%1"

:: PDF oeffnen wenn %2 gesetzt
if [%2] == [1] (
	echo Parameter 2 gesetzt
	"%1".pdf
)
if [%2] == [] echo Parameter 2 nicht gesetzt


::exit

:cleanup
del *.dvi
del *.out
::del *.log 
del *.lot
del *.tmp
del *.aux  
del *.bbl    
del *.ind
del *.blg  
del *.brf 
del *.idx
del *.lof
del *.nlo
del *.nls
del *.toc
del *.ilg
del *.lol
