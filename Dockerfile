FROM node:24 AS build

WORKDIR /lab2
COPY ./ ./
RUN npm install
RUN npm run build 

FROM node:24-alpine 

WORKDIR /lab2
COPY --from=build /lab2/dist /lab2/dist 
COPY --from=build /lab2/package*.json /lab2
RUN npm install --only=production

EXPOSE 3000
CMD ["node”, “dist/main.js"]
