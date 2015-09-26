FROM alpine:3.2

RUN apk add --update tar curl openssh-client \
&& mkdir /caddysrc \
&& mkdir -p /srv/conf \
&& curl -sL -o /caddysrc/caddy_linux_amd64.tar.gz "https://github.com/mholt/caddy/releases/download/v0.7.5/caddy_linux_amd64.tar.gz" \
&& tar -xf /caddysrc/caddy_linux_amd64.tar.gz -C /caddysrc \
&& mv /caddysrc/caddy /usr/bin/caddy \
&& chmod 755 /usr/bin/caddy \
&& rm -Rf /caddysrc \
&& printf "0.0.0.0\nbrowse" > /srv/conf/Caddyfile

EXPOSE 2015 
WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/srv/conf/Caddyfile"]

