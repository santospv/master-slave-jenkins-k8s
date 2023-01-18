FROM httpd:2.4

COPY ./page/ /usr/local/apache2/htdocs/

ENV PORT 80
EXPOSE 80