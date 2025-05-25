FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Копируем только csproj
COPY test/*.csproj ./test/
WORKDIR /src/test

RUN dotnet restore

# Копируем исходники
COPY test/. ./

RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "test.dll"]
