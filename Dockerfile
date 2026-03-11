FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

FROM node:18-alpine AS production

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules

COPY --from=builder /app .

EXPOSE 5000

CMD [ "npm", "start" ]