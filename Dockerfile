FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base

# Install node/npm
RUN apt-get -y update && apt-get -y install curl
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - &&\
apt-get install -y nodejs

# Copy across code
WORKDIR /module-9
COPY . /module-9/

# Build
RUN dotnet build
WORKDIR /module-9/DotnetTemplate.Web
RUN npm install 
RUN npm run build

# Run tests
FROM base AS ts-tests
ENTRYPOINT npm t

FROM base as lint-tests
ENTRYPOINT npm run lint

FROM base AS cs-tests
WORKDIR /module-9
ENTRYPOINT dotnet test

# Build app
FROM base AS prod
WORKDIR /module-9/DotnetTemplate.Web
EXPOSE 8088
ENTRYPOINT dotnet run --bind 0.0.0.0:8088