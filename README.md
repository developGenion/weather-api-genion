# Weather App Backend Documentation

This documentation provides an overview of the routes and functionalities of the Weather App backend. The backend is built with Flask and is responsible for connecting to the OpenWeatherMap API, processing information, and storing it in a PostgreSQL database.

**Tools Used:**
- Python (^3.8): [Official Python Website](https://www.python.org/)
- flask (^2.3): [Official flask Website](https://flask.palletsprojects.com/en/2.3.x/)
- postgres (^14.9): [postgres Official Website](https://www.postgresql.org/)


## Installation and Setup

To run the Weather App backend on your local machine, follow these steps:

1. **Clone the repository:** Open your terminal and run the following command to clone the repository:

   ```bash
   $ git clone https://github.com/developGenion/weather-api-genion.git
   ```


2. **Navigate to the project directory:** Change your current directory to the project folder:

   ```bash
   $ cd weather-api-genion
   ```

3. **Create a virtual environment:** Create a Python virtual environment to isolate project dependencies:

   ```bash
   $ python3 -m venv venv
   ```

4. **Activate the virtual environment:** Activate the virtual environment. The activation command varies depending on your operating system:

   - On macOS and Linux:

     ```bash
     $ source venv/bin/activate
     ```

   - On Windows:

     ```bash
     $ venv\Scripts\activate
     ```

5. **Install dependencies:** Install the required Python packages from the `requirements.txt` file:

   ```bash
   $ pip install -r requirements.txt
   ```

6. **Run Flask:** Start the Flask application:

   ```bash
   $ flask run
   ```


## Troubleshooting Installation Issues

### Error: Missing Prerequisites for psycopg2 Installation

If you encounter an error message indicating that you're missing prerequisites required to build the psycopg2 package from source, such as the `x86_64-linux-gnu-gcc` compiler, follow these steps to resolve the issue:

#### 1. Install `psycopg2-binary` Package

The recommended approach is to use the `psycopg2-binary` package, which is a pre-built binary package that doesn't require compilation. You can install it using `pip`:

```bash
pip3 install psycopg2-binary
```

#### 2. Install `libpq-dev` Package

You may also need to install the `libpq-dev` package to satisfy PostgreSQL development library dependencies:

On a Debian-based system (e.g., Ubuntu), you can install the necessary build tools and libraries with the following command:

```bash
sudo apt-get install python3-dev libpq-dev build-essential
```

On a Red Hat-based system (e.g., CentOS), you can use:

```bash
sudo yum install python3-devel postgresql-devel gcc
```

These commands will ensure that you have the required libraries and tools to build and install psycopg2 successfully.

By following these steps, you should be able to resolve any missing prerequisites or compilation errors related to psycopg2 installation.



## Configuration

Ensure that you configure the PostgreSQL database connection correctly and provide the OpenWeatherMap API key in the `app.py` file before running the backend.

To configure the database, modify the parameters in the `Controllers/__init__.py` file (`user_base`, `password`, `bd`) to match your specific database settings.

   ```__init__
      postgres://user_base:password@localhost:5432/bd
   ```

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

#### Route: `/weather` (POST)

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



## Contact

If you have any questions or need further assistance, feel free to contact the development team at [info@genion.com.co](mailto:info@genion.com.co).