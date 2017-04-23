FROM perl

RUN apt-get update
RUN apt-get install -y gnuplot
RUN apt-get install -y --no-install-recommends texlive-latex-extra
RUN apt-get install -y --no-install-recommends texlive-fonts-recommended
RUN cpan Devel::Trace

ADD bottle.py /scigen/
RUN apt-get install -y --no-install-recommends ghostscript
WORKDIR /scigen
ADD scigen.py .
ADD latex /usr/local/bin/latex
ADD views/ .
ENTRYPOINT python scigen.py
RUN apt-get install -y --no-install-recommends graphviz
