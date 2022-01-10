FROM node:fermium-bullseye
MAINTAINER holao09 <mrholao09@gmail.com>

RUN apt-get update && apt-get install -y git
RUN mkdir -p /app
RUN git clone https://github.com/nRFCloud/thingy-world-app.git /app
RUN cd /app && npm i && npm run build
CMD cd /app && npm run local
