# Project App Portfolio Golang Azwin

A web portfolio application built with Golang backend and HTML/CSS/JavaScript frontend template. This is mini-project for lumoshive golang bootcamp.

Link Video : https://youtu.be/G3wgKpvlkbw
## Features

- Homepage with portfolio overview
- Portfolio page displaying projects
- Contact form with message submission
- About page
- CV download functionality
- Responsive design using Bootstrap

## Tech Stack

- **Backend**: Golang
- **Database**: SQLite (or configured database)
- **Frontend**: HTML, CSS, JavaScript
- **Templates**: Go HTML templates
- **Styling**: Bootstrap, Font Awesome
- **JavaScript Libraries**: jQuery, Isotope, Magnific Popup

## Installation

1. Clone the repository:

   ```
   git clone <repository-url>
   cd project-app-portfolio-golang-azwin
   ```

2. Install Go dependencies:

   ```
   go mod tidy
   ```

3. Set up the database:

   - Run the SQL schema from `database/schema.sql`
   - Configure database connection in `database/database.go`

4. Build and run the application:

   ```
   go run main.go
   ```

5. Open your browser and navigate to `http://localhost:8080`

## Usage

- Visit the homepage at `/`
- View portfolio at `/portfolio`
- Contact form at `/contact`
- About page at `/about`
- Download CV at `/download/cv`

## Project Structure

```
.
├── main.go                 # Application entry point
├── database/
│   ├── database.go         # Database connection and setup
│   └── schema.sql          # Database schema
├── dto/
│   └── contact.go          # Data transfer objects
├── handler/
│   └── handler.go          # HTTP handlers
├── logs/                   # Log files
├── middleware/
│   ├── contact_message.go
│   ├── logging.go
│   └── middeware.go        # Middleware functions
├── model/
│   ├── contact.go          # Contact message model
│   └── project.go          # Project model
├── public/                 # Static assets (CSS, JS, images)
├── repository/
│   ├── contact_repo.go     # Contact repository
│   └── project_repo.go     # Project repository
├── router/
│   └── router.go           # Route definitions
├── service/
│   ├── contact_service.go  # Contact service
│   ├── project_service.go  # Project service
│   └── service.go          # Service layer
├── template/               # HTML templates
├── utils/                  # Utility functions
└── views/                  # Template views
    ├── layouts/
    └── pages/
```

## Database Setup

1. Create a database using the schema in `database/schema.sql`
2. Update database connection settings in `database/database.go`
3. Run migrations if needed

## API Endpoints

- `GET /` - Homepage
- `GET /portfolio` - Portfolio page
- `GET /contact` - Contact page
- `POST /contact/send` - Submit contact form
- `GET /about` - About page
- `GET /download/cv` - Download CV

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License.
