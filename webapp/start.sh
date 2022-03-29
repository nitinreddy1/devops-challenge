#!/bin/bash

articles=()
index=0
IFS=$'\n';for i in `cat articles.txt`;do
  articles[index]+=${i}
  let index++
done

article=${articles[$((RANDOM%${#articles[*]}))]}

echo "<!DOCTYPE html> \
        <html lang="ja"> \
        <meta charset="utf-8"> \
        <title>Lorem Ipsum</title> \
        </head> \
        <body> \
        <div align="center"> \
        <h1>Lorem Ipsum</h1> \
        <p>${article}</p>
        </div> \
        </body> \
        </html>" \
        > /usr/share/nginx/html/index.html

chmod 644 /usr/share/nginx/html/index.html

/bin/bash -c "nginx -g 'daemon off;'"
