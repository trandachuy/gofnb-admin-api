#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /src
COPY ["GoFoodBeverage.WebApi/GoFoodBeverage.WebApi.csproj", "GoFoodBeverage.WebApi/"]
RUN dotnet restore "GoFoodBeverage.WebApi/GoFoodBeverage.WebApi.csproj"
RUN dotnet tool install --global dotnet-ef
RUN export PATH="$PATH:/root/.dotnet/tools"
RUN dotnet ef database update --context $(dbContext) --connection "Server=tcp:qa-gofnb-sqlserver.database.windows.net,1433;Initial Catalog=qa-gofood-beverage-db;Persist Security Info=False;User ID=qa-gofood-beverage-admin;Password=4Kda3Pt$4BH#J1dIU38;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
COPY . .
WORKDIR "/src/GoFoodBeverage.WebApi"
RUN dotnet build "GoFoodBeverage.WebApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "GoFoodBeverage.WebApi.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "GoFoodBeverage.WebApi.dll"]
