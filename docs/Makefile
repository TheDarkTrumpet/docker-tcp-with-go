architecture_diagram = ArchitectureDiagram.drawio
demo_diagram = DemoDiagram.drawio

build: clean build_diags
	$(build_diags)
	pdflatex -shell-escape 01-SeriesIntro.tex
	pdflatex -shell-escape 01-SeriesIntro.tex  # For TOC
	pdflatex -shell-escape 02-IntroDocker.tex
	pdflatex -shell-escape 02-IntroDocker.tex  # For TOC
	pdflatex -shell-escape 03-RunStrategies.tex
	pdflatex -shell-escape 03-RunStrategies.tex # For TOC
	pdflatex -shell-escape XX-UFGPresentation.tex
	pdflatex -shell-escape XX-UFGPresentation.tex # For TOC
	pdflatex -shell-escape XX-UFGHandout.tex

build_diags:
	drawio -x -f png -e -p 0 -o ./02-DockerVsVMs.png $(architecture_diagram)
	drawio -x -f png -e -p 1 -o ./02-DockerRunArch.png $(architecture_diagram)
	drawio -x -f png -e -p 2 -o ./02-DockerNetwork.png $(architecture_diagram)
	drawio -x -f png -e -p 0 -o ./03-General.png $(demo_diagram)
	drawio -x -f png -e -p 1 -o ./03-monolithic.png $(demo_diagram)
	drawio -x -f png -e -p 2 -o ./03-serverclient.png $(demo_diagram)
	drawio -x -f png -e -p 3 -o ./03-micro.png $(demo_diagram)

clean:
	rm -f *.aux *.log *.nav *.snm *.toc 0*.png *.out
	rm -Rf _minted*

all: build
