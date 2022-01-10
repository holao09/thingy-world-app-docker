FROM node:fermium-bullseye
MAINTAINER holao09 <mrholao09@gmail.com>

ENV API_KEY=339c3ded227a209355f0a3e8dadf168768ef387a
RUN apt-get update && apt-get install -y git
RUN mkdir -p /app
RUN git clone https://github.com/nRFCloud/thingy-world-app.git /app
RUN cd /app && sed -i '/"local":/s/.*/    "local": "live-server --host=0.0.0.0 --port=8080 --cors dist\/",/' package.json

RUN cd /app && npm i && npm run build
CMD cd /app && \
  sed -i "/\"Authorization\":/s/.*/            \"Authorization\": \"Bearer $API_KEY\",/" assets/js/scripts.js && \
  npm run local
