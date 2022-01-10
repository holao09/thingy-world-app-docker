FROM node:fermium-bullseye
MAINTAINER holao09 <mrholao09@gmail.com>

ENV API_KEY=339c3ded227a209355f0a3e8dadf168768ef387a
ENV CESIUM_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI5ZWMwMDU0Yi03MjFlLTQ2YmYtODRjMC1iOTliZTcyZGE5OGQiLCJpZCI6NzkwNDEsImlhdCI6MTY0MTc5ODk1NX0.zVa_LrsoIaHTznoZCNGggWk__kEAlXH-iWvWU9LwuE8
RUN apt-get update && apt-get install -y git
RUN mkdir -p /app
RUN git clone https://github.com/nRFCloud/thingy-world-app.git /app
RUN cd /app && sed -i '/"local":/s/.*/    "local": "live-server --cors dist\/ --host=0.0.0.0 --port=8888",/' package.json

RUN cd /app && npm i && npm run build
CMD cd /app && \
  sed -i "s/Authorization:\"Bearer .*?\"/Authorization:\"Bearer $API_KEY\"/g" dist/js/scripts-min.js && \
  sed -i "s/defaultAccessToken=\".*?\"/defaultAccessToken=\"$CESIUM_KEY\"/g" dist/js/Cesium/Cesium.js && \
  npm run local
