FROM appdynamics/dotnet-core-agent AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2.103-sdk AS build
WORKDIR /src
COPY ["GoFoodBeverage.WebApi/GoFoodBeverage.WebApi.csproj", "WebApp/FileManager.WebApp/"]
RUN dotnet restore "WebApp/FileManager.WebApp/GoFoodBeverage.WebApi.csproj"
WORKDIR /src/WebApp/FileManager.WebApp
COPY . .
RUN dotnet build "GoFoodBeverage.WebApi.csproj" -c Release -o /app
RUN dotnet ef database update --context GoFoodBeverageDbContext --connection "Server=14.161.27.198,11433;Initial Catalog=dev-go-food-beverage-db;Persist Security Info=False;User ID=dev-gofood-beverage-admin;Password=tm(8y'2Y$J-f/dL;MultipleActiveResultSets=true;Encrypt=True;TrustServerCertificate=True;Connection Timeout=30;"

FROM build AS publish
RUN dotnet publish "GoFoodBeverage.WebApi.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
COPY GoFoodBeverage.WebApi/wwwroot/. /app/wwwroot
ENTRYPOINT ["dotnet", "GoFoodBeverage.WebApi.dll"]
