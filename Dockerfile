FROM manticoresearch/manticore:dev as manticore

RUN cd ~ && wget https://repo.manticoresearch.com/manticore-repo.noarch.deb \
 && dpkg -i manticore-repo.noarch.deb \
 && apt -y update \
 && apt -y install manticore-lemmatizer-uk build-essential zlib1g-dev libncurses5-dev libgdbm-dev \
    libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev \
 && cd ~ && wget https://www.python.org/ftp/python/3.9.4/Python-3.9.4.tgz \
 && tar xzf Python-3.9.4.tgz && cd Python-3.9.4 \
 && ./configure --enable-optimizations --enable-shared \
 && make -j8 altinstall && ldconfig \
 && cd ~ && rm Python-3.9.4* -rf \
 && pip3.9 install pymorphy2[fast] \
 && pip3.9 install pymorphy2-dicts-uk \
 && apt -y remove build-essential && apt -y autoremove && apt clean