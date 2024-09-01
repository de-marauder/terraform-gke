FROM node:14-slim

WORKDIR /app

COPY package*.json yarn.lock ./
RUN npm install --only=production

COPY . .

EXPOSE 8080
CMD ["node", "index.js"]
