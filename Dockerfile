FROM node:24 AS build
WORKDIR /lab2
COPY . .
RUN npm install
RUN npm run build 

FROM node:24-alpine 
WORKDIR /lab2
COPY --from=build /lab2/dist ./dist
COPY --from=build /lab2/package*.json ./
RUN npm install --only=production

EXPOSE 3000

CMD ["node", "dist/main.js"]