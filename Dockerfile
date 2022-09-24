FROM cloudron/base:3.2.0@sha256:ba1d566164a67c266782545ea9809dc611c4152e27686fd14060332dd88263ea

RUN mkdir -p /app/data /app/code
WORKDIR /app/code

RUN curl -L https://github.com/conflict-investigations/media-search-engine/archive/master.tar.gz | tar -xzv -C /app/code --strip-components 1 -f -

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

ARG VERSION=0.0.1

ENV VIRTUAL_ENV=/app/code/.venv
RUN virtualenv ${VIRTUAL_ENV}
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip3 install flask gunicorn
RUN pip3 install -e .

COPY start.sh /app/code

WORKDIR /app/data
EXPOSE 8000
CMD [ "/app/code/start.sh" ]
