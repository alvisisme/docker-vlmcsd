FROM alvisisme/ubuntu:16.04
LABEL maintainer="Alvis Zhao<alvisisme@163.com>"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y gcc make wget && \
    wget https://codeload.github.com/alvisisme/vlmcsd/tar.gz/svn1112 -O svn1112.tar.gz && \
    tar xzf svn1112.tar.gz && \
    cd vlmcsd-svn1112 && \
    make && \
    cp bin/vlmcsd /usr/local/bin/ && \
    cp bin/vlmcs /usr/local/bin/ && \
    chmod +x /usr/local/bin/vlmcsd && \
    chmod +x /usr/local/bin/vlmcs && \
    cd .. && \
    rm -rf vlmcsd-svn1112 && \
    rm svn1112.tar.gz && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 1688

CMD ["/usr/local/bin/vlmcsd", "-D", "-d", "-t", "3", "-e", "-v"]
