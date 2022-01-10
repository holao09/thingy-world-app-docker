FROM node:fermium-bullseye
MAINTAINER holao09 <mrholao09@gmail.com>

RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/nRFCloud/thingy-world-app.git .
RUN npm i && npm run build
CMD npm run local
