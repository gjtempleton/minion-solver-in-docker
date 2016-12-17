FROM alpine
MAINTAINER Guy Templeton (guyjtempleton@googlemail.com)

ARG GITSHA="VCS ref not found"
ARG BUILDDATE="Build date not found"
LABEL org.label-schema.vendor="Guy Templeton" \
      org.label-schema.url="https://github.com/gjtempleton/minion-solver-in-docker" \
      org.label-schema.name="Minion in Docker" \
      org.label-schema.license="GPLv2" \
      org.label-schema.vcs-url="https://github.com/gjtempleton/minion-solver-in-docker" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.description="Simple repo packaging the Minion Constraint Solver (https://bitbucket.org/stacs_cp/minion) in Docker" \
      org.label-schema.vcs-ref=$GITSHA \
      org.label-schema.build-date=$BUILDDATE

RUN apk update && \
    apk add mercurial python ca-certificates gcc g++ make && \
    hg clone https://bitbucket.org/stacs_cp/minion /temp && \
	cd /temp && mkdir bin && \
	cd bin && \
	../build.py && \
	make minion && \
	mv minion /bin/minion && \
	rm -rf /temp
ENTRYPOINT ["/bin/minion"]
