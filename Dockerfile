FROM mongo:3.2
ADD ./init.sh /init.sh
CMD ["/init.sh"]
