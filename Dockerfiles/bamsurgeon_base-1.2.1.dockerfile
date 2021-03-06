FROM ubuntu:16.04

ENV HOME=/usr/local/
WORKDIR /usr/local

RUN apt-get update && apt-get install -y zlib1g-dev git wget libncurses5-dev unzip python python-pip libbz2-dev liblzma-dev pkg-config automake libglib2.0-dev openjdk-8-jdk software-properties-common bowtie2 bedtools tabix vcftools
RUN apt-get clean

# pysam 0.14.1 had problem with copy function
RUN pip install numpy scipy cython==0.27.3 pysam==0.13

RUN cd $HOME
RUN wget https://www.ebi.ac.uk/~zerbino/velvet/velvet_1.2.10.tgz && tar xvzf velvet_1.2.10.tgz && make -C velvet_1.2.10 && cp velvet_1.2.10/velvetg $HOME/bin && cp velvet_1.2.10/velveth $HOME/bin
RUN wget https://github.com/lh3/bwa/archive/v0.7.17.tar.gz && tar -xvf v0.7.17.tar.gz && make -C bwa-0.7.17 && cp bwa-0.7.17/bwa $HOME/bin
RUN git clone https://github.com/samtools/htslib.git && make -C htslib
RUN git clone https://github.com/samtools/samtools.git && make -C samtools && cp samtools/samtools $HOME/bin && cp samtools/misc/wgsim $HOME/bin
RUN git clone https://github.com/samtools/bcftools.git && make -C bcftools && cp bcftools/bcftools $HOME/bin
RUN wget https://github.com/broadinstitute/picard/releases/download/1.131/picard-tools-1.131.zip && unzip picard-tools-1.131.zip
RUN wget http://ftp.gnu.org/gnu/automake/automake-1.14.1.tar.gz && tar -xvf automake-1.14.1.tar.gz && cd automake-1.14.1 && ./configure && make && make install
RUN cd $HOME && git clone https://github.com/adamewing/exonerate.git && cd exonerate && git checkout v2.4.0 && autoreconf -i && ./configure && make && make install
RUN cd $HOME && wget http://research-pub.gene.com/gmap/src/gmap-gsnap-2018-05-30.tar.gz && tar -xvf gmap-gsnap-2018-05-30.tar.gz && cd gmap-2018-05-30/ && ./configure && make && make install && cd .. && ln -s gmap-2018-05-30 gmap
RUN cd $HOME/bin && wget https://www.dropbox.com/s/rbegan3opz2fc4k/vcfsorter.pl && chmod a+x vcfsorter.pl
RUN cd $HOME/bin && wget https://github.com/broadinstitute/picard/releases/download/2.18.7/picard.jar
