# Uses Node.js version 18 as the base image.
FROM node:18

# Sets the working directory inside the container.
WORKDIR /app

# Copies package.json to the container.
COPY package.json .

#Installs dependencies inside the container.
RUN npm install

# Copies all project files to the container.
COPY . .

# Exposes (informs) that the app will run on port 3000.
EXPOSE 3000

# Defines the command that will start the application when the container runs.
CMD ["node", "server.js"]
