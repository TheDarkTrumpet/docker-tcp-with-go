build:
	$(clean)
	$(build_diags)
	pdflatex 02-IntroDocker.tex

build_diags:
	draw.io -x -f png -e -p 1 -o ./02-DockerVsVMs.png
	draw.io -x -f png -e -p 2 -o ./02-DockerRunArch.png
	draw.io -x -f png -e -p 3 -o ./02-DockerNetwork.png

clean:
	rm *.aux
	rm *.log
	rm *.nav
	rm *.snm
	rm *.toc
	rm *.png

all: build
