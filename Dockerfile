FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY PeopleRegistration.sln ./
COPY PeopleRegistration.Api/PeopleRegistration.Api.csproj PeopleRegistration.Api/
COPY PeopleRegistration.Domain/PeopleRegistration.Domain.csproj PeopleRegistration.Domain/
COPY PeopleRegistration.Infra/PeopleRegistration.Infra.csproj PeopleRegistration.Infra/
COPY PeopleRegistration.Tests/PeopleRegistration.Tests.csproj PeopleRegistration.Tests/

RUN dotnet restore PeopleRegistration.sln

COPY . ./

RUN dotnet publish PeopleRegistration.Api/PeopleRegistration.Api.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

EXPOSE 8080

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "PeopleRegistration.Api.dll"]


