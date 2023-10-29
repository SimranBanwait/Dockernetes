FROM node:alpine3.17 as ReactContainer
WORKDIR /Portfolio
COPY package.json /Portfolio
RUN npm install
COPY . /Portfolio/ 
CMD npm run build
EXPOSE 3000

#nginx block
FROM nginx:1.23-alpine as NginxContainer
WORKDIR /usr/share/nginx/html
RUN rm /usr/share/nginx/html/index.html
RUN rm /usr/share/nginx/html/50x.html
RUN chmod -R 755 /usr/share/nginx/html
COPY --from=ReactContainer /Portfolio/build .
ENTRYPOINT [ "nginx","-g","daemon off;" ]
EXPOSE 80
