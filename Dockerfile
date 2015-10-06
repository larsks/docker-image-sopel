FROM fedora

RUN mkdir /etc/sopel

RUN dnf -y install \
	python-lxml \
	python-enchant \
	python-feedparser \
	pytz \
	python-GeoIP \
	python-praw \
	python-pip \
	python-jinja2 \
	git \
	; dnf clean all

RUN pip install git+https://github.com/larsks/sopel.git@feature/msgrate
RUN useradd -c 'Sopel User' sopel

COPY envtemplate /bin/envtemplate
COPY default.cfg.in /etc/sopel/default.cfg.in
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["runuser", "-u", "sopel", "--", "sopel", "-c", "/home/sopel/default.cfg"]
