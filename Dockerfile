# Get Base Image (Full .NET Core SDK)
#mcr.microsoft.com/dotnet/core/sdk:2.2
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Generate runtime image
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /app
# ARG BUILD_CONFIGURATION=Debug
# ENV ASPNETCORE_ENVIRONMENT=Development
# ENV DOTNET_USE_POLLING_FILE_WATCHER=true  
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "TerraFormWebApi.dll"]