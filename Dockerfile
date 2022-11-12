# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source
COPY *.sln .
COPY GoFoodBeverage.WebApi/*.*.csproj ./aspnetapp/
RUN dotnet restore ./aspnetapp/*.*.csproj
RUN dotnet ef database update --context GoFoodBeverageDbContext --connection "Server=14.161.27.198,11433;Initial Catalog=dev-go-food-beverage-db;Persist Security Info=False;User ID=dev-gofood-beverage-admin;Password=tm(8y'2Y$J-f/dL;MultipleActiveResultSets=true;Encrypt=True;TrustServerCertificate=True;Connection Timeout=30
COPY GoFoodBeverage.WebApi/. ./aspnetapp/
WORKDIR /source/aspnetapp
RUN dotnet publish -c release -o /app --no-restore
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
