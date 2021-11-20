architecture_diagram = ArchitectureDiagram.drawio

build: clean build_diags
	$(build_diags)
	pdflatex -shell-escape 01-SeriesIntro.tex
	pdflatex -shell-escape 02-IntroDocker.tex

build_diags:
	draw.io -x -f png -e -p 0 -o ./02-DockerVsVMs.png $(architecture_diagram)
	draw.io -x -f png -e -p 1 -o ./02-DockerRunArch.png $(architecture_diagram)
	draw.io -x -f png -e -p 2 -o ./02-DockerNetwork.png $(architecture_diagram)

clean:
	rm -f *.aux *.log *.nav *.snm *.toc *.png *.out
	rm -Rf _minted*

all: build
