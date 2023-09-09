# Weather App Backend Documentation

This documentation provides an overview of the routes and functionalities of the Weather App backend. The backend is built with Flask and is responsible for connecting to the OpenWeatherMap API, processing information, and storing it in a PostgreSQL database.

## Routes and Functionalities

### Get Information About a City

#### Route: `/city` (GET)

- **Description:** This route allows you to obtain information about a specific city by providing its name, latitude, and longitude as query parameters.

- **Query Parameter:**
  - `city` (Required): The name of the city for which you want to retrieve information.

- **Responses:**
  - 200 OK: Valid city information is returned.
  - 400 Bad Request: If the city name is not provided or if any other error occurs.

### Get Weather Forecast for a Specific Location

#### Route: `/clima` (POST)

- **Description:** This route allows you to obtain the weather forecast for a specific location by providing the longitude and latitude coordinates.

- **Request Body (JSON):**
  - `lon` (Required): Longitude of the location.
  - `lat` (Required): Latitude of the location.

- **Responses:**
  - 200 OK: Valid weather forecast information is returned.
  - 400 Bad Request: If the coordinates are not provided or if any other error occurs.

### Save a City as Favorite

#### Route: `/my_favorite` (POST)

- **Description:** This route allows a user to save a city as a favorite.

- **Request Body (JSON):**
  - `name` (Required): Name of the city.
  - `in_lon` (Required): Longitude of the city.
  - `in_lat` (Required): Latitude of the city.
  - `session` (Required): User's session identifier.

- **Responses:**
  - 200 OK: The city is successfully saved as a favorite.
  - 404 Not Found: If the user's session is not found.
  - 500 Internal Server Error: If any other error occurs.

### Create or Retrieve User Session

#### Route: `/user` (POST)

- **Description:** This route allows you to create or retrieve a user's session.

- **Request Body (JSON):**
  - `ssesion_id` (Required): Session identifier.

- **Responses:**
  - 200 OK: The user's session is successfully created or retrieved, and favorite cities are returned if available.
  - 500 Internal Server Error: If an error occurs while creating or retrieving the session.

### Save Weather Query History

#### Route: `/history` (POST)

- **Description:** This route allows you to save the weather query history of a user.

- **Request Body (JSON):**
  - `date_time` (Required): Date and time of the query.
  - `temp` (Required): Temperature queried.
  - `city` (Required): Name of the queried city.
  - `description` (Required): Description of the queried weather.
  - `icon` (Required): Icon of the queried weather.
  - `ssesion` (Required): User's session identifier.

- **Responses:**
  - 200 OK: The query history is successfully saved.
  - 500 Internal Server Error: If any error occurs while saving the history.

### Get Weather Query History

#### Route: `/history` (GET)

- **Description:** This route allows you to retrieve the weather query history of a user by their session identifier.

- **Query Parameter:**
  - `session` (Required): User's session identifier.

- **Responses:**
  - 200 OK: The user's weather query history is returned.
  - 404 Not Found: If the user's history is not found.

## Configuration

Ensure that you configure the PostgreSQL database connection correctly and provide the OpenWeatherMap API key in the `main.py` file before running the backend.

To configure the database, modify the parameters in the `Controllers/__init__.py` file (`user_base`, `password`, `clima`) to match your specific database settings.

## Contact

If you have any questions or need further assistance, feel free to contact the development team at [info@genion.com.co](mailto:info@genion.com.co).