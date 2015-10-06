#!/bin/sh

: ${SOPEL_DIR:=/home/sopel}
: ${SOPEL_IRC_HOST:=localhost}
: ${SOPEL_IRC_PORT:=6667}
: ${SOPEL_IRC_SSL:=false}

export SOPEL_IRC_HOST SOPEL_IRC_PORT SOPEL_IRC_SSL

for var in SOPEL_NICK SOPEL_OWNER SOPEL_CHANNELS; do
	if [ -z "${!var}" ]; then
		echo "ERROR: missing required variable $var" >&2
		exit 1
	fi
done

if [ ! -f $SOPEL_DIR/default.cfg ]; then
	envtemplate -E \
		/etc/sopel/default.cfg.in > $SOPEL_DIR/default.cfg
fi

chown -R sopel:sopel $SOPEL_DIR

exec runuser -u sopel -- "$@"

