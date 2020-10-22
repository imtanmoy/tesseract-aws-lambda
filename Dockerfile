
FROM amazonlinux:2.0.20200722.0

ENV LEPTONICA_VERSION="1.80.0"
# docker_build leptonica
WORKDIR /tmp/

RUN yum -y clean expire-cache && yum -y makecache fast && yum -y update && \
    yum -y install tar xz gcc gcc-c++ make autoconf aclocal automake libtool findutils \
    libjpeg-devel libpng-devel libtiff-devel zlib-devel \
    libzip-devel freetype-devel lcms2-devel libwebp-devel \
    tcl-devel tk-devel wget tar diffutils autoconf automake \
    libjpeg8-devel libtiff5-devel zlib1g-devel zip \
     clang zip gzip libjpeg-turbo-devel pkgconfig


RUN wget https://github.com/DanBloomberg/leptonica/releases/download/$LEPTONICA_VERSION/leptonica-$LEPTONICA_VERSION.tar.gz
RUN tar -xzvf leptonica-$LEPTONICA_VERSION.tar.gz
RUN cd leptonica-$LEPTONICA_VERSION && ./configure && make && make install

RUN wget http://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-2019.01.06.tar.xz
RUN tar -xvf autoconf-archive-2019.01.06.tar.xz
RUN cd autoconf-archive-2019.01.06 && ./configure && make && make install
RUN cd autoconf-archive-2019.01.06 && cp m4/* /usr/share/aclocal/

COPY build_tesseract.sh /tmp/build_tesseract.sh
RUN chmod +x /tmp/build_tesseract.sh
CMD sh /tmp/build_tesseract.sh