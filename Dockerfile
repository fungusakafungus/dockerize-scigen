FROM perl

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
	ghostscript \
	gnuplot \
	texlive-fonts-recommended \
	texlive-latex-extra

WORKDIR /scigen
ENTRYPOINT python scigen.py
ADD latex /usr/local/bin/latex
ADD bottle.py /scigen/
ADD scigen.py .
ADD views/ .
