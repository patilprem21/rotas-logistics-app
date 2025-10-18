# Use the official ASP.NET Core runtime as the base image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Use the official ASP.NET Core SDK for building
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["RotasLogisticsApp.csproj", "."]
RUN dotnet restore "RotasLogisticsApp.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet build "RotasLogisticsApp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "RotasLogisticsApp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "RotasLogisticsApp.dll"]
