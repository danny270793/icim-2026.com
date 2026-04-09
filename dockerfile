FROM php:8.3-cli

WORKDIR /var/www/html

COPY code/ ./

EXPOSE 8080

# Serve static files and any .php from ./code (WORKDIR)
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
