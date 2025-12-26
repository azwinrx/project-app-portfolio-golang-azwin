package handler

import (
	"fmt"
	"html/template"
	"io"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"project-app-portfolio-golang-azwin/dto"
	"project-app-portfolio-golang-azwin/model"
	"project-app-portfolio-golang-azwin/service"
)

// PortofolioHandler menangani request untuk halaman portfolio
type PortofolioHandler struct {
	service service.ProjectService
	tmpl    *template.Template
}

// NewPortofolioHandler constructor untuk PortofolioHandler
func NewPortofolioHandler(svc service.ProjectService) *PortofolioHandler {
	// Parse templates
	tmpl := template.Must(template.ParseFiles(
		filepath.Join("views", "layouts", "header.html"),
		filepath.Join("views", "layouts", "footer.html"),
		filepath.Join("views", "layouts", "newsletter.html"),
		filepath.Join("views", "pages", "portfolio.html"),
	))
	return &PortofolioHandler{service: svc, tmpl: tmpl}
}

// PortofolioPageView menangani GET /portofolio - menampilkan halaman portfolio dengan data project
func (h *PortofolioHandler) PortofolioPageView(w http.ResponseWriter, r *http.Request) {
	// Panggil service untuk mendapatkan semua project
	projects, err := h.service.GetAllProjects(r.Context())
	if err != nil {
		log.Printf("Error getting projects: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	log.Printf("Retrieved %d projects", len(projects))

	// Data untuk template
	data := struct {
		Title    string
		Projects []model.Project
	}{
		Title:    "Portfolio",
		Projects: projects,
	}

	// Render template
	w.Header().Set("Content-Type", "text/html")
	if err := h.tmpl.ExecuteTemplate(w, "portfolio", data); err != nil {
		log.Printf("Template error: %v", err)
		http.Error(w, "Template Error", http.StatusInternalServerError)
	}
}

// HomeHandler menangani request untuk halaman home
type HomeHandler struct {
	service service.ProjectService
	tmpl    *template.Template
}

// NewHomeHandler constructor untuk HomeHandler
func NewHomeHandler(svc service.ProjectService) *HomeHandler {
	// Parse templates
	tmpl := template.Must(template.ParseFiles(
		filepath.Join("views", "layouts", "header.html"),
		filepath.Join("views", "layouts", "skill.html"),
		filepath.Join("views", "layouts", "footer.html"),
		filepath.Join("views", "layouts", "newsletter.html"),
		filepath.Join("views", "layouts", "portofolio.html"),
		filepath.Join("views", "pages", "index.html"),
	))
	return &HomeHandler{service: svc, tmpl: tmpl}
}

// HomepageView menangani GET / - menampilkan halaman home
func (h *HomeHandler) HomepageView(w http.ResponseWriter, r *http.Request) {
	// Panggil service untuk mendapatkan semua project
	projects, err := h.service.GetAllProjects(r.Context())
	if err != nil {
		log.Printf("Error getting projects: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	log.Printf("Retrieved %d projects for home", len(projects))

	// Data untuk template
	data := struct {
		Title    string
		Projects []model.Project
	}{
		Title:    "Satner Portfolio",
		Projects: projects,
	}

	// Render template
	w.Header().Set("Content-Type", "text/html")
	if err := h.tmpl.ExecuteTemplate(w, "home", data); err != nil {
		log.Printf("Template error: %v", err)
		http.Error(w, "Template Error", http.StatusInternalServerError)
	}
}

// AboutHandler menangani request untuk halaman about
type AboutHandler struct {
	tmpl *template.Template
}

// NewAboutHandler constructor untuk AboutHandler
func NewAboutHandler() *AboutHandler {
	// Parse templates
	tmpl := template.Must(template.ParseFiles(
		filepath.Join("views", "layouts", "header.html"),
		filepath.Join("views", "layouts", "footer.html"),
		filepath.Join("views", "layouts", "newsletter.html"),
		filepath.Join("views", "pages", "about.html"),
	))
	return &AboutHandler{tmpl: tmpl}
}

// AboutpageView menangani GET /about - menampilkan halaman about
func (h *AboutHandler) AboutpageView(w http.ResponseWriter, r *http.Request) {
	// Data untuk template
	data := struct {
		Title string
	}{
		Title: "About Us",
	}

	// Render template
	w.Header().Set("Content-Type", "text/html")
	if err := h.tmpl.ExecuteTemplate(w, "about", data); err != nil {
		http.Error(w, "Template Error", http.StatusInternalServerError)
	}
}

// DownloadHandler stub untuk download
type DownloadHandler struct{}

// DownloadCV menangani GET /download/cv
func (h *DownloadHandler) DownloadCV(w http.ResponseWriter, r *http.Request) {
	filePath := "public/document/Muhammad Azwin Rifai_CV_Academy2026.pdf"
	file, err := os.Open(filePath)
	if err != nil {
		log.Printf("Error opening file: %v", err)
		http.Error(w, "File not found", http.StatusNotFound)
		return
	}
	defer file.Close()

	// Set headers Response
	w.Header().Set("Content-Disposition", "attachment; filename=Muhammad Azwin Rifai_CV_Academy2026.pdf")
	w.Header().Set("Content-Type", "application/pdf")
	w.Header().Set("Content-Length", fmt.Sprintf("%d", getFileSize(filePath)))

	// Salin file ke response writer
	_, err = io.Copy(w, file)
	if err != nil {
		log.Printf("Error copying file: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
	}
}

// SeeCV menangani GET /download/cv-detail
func (h *DownloadHandler) SeeCV(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("See CV Detail"))
}

// ContactHandler menangani request untuk halaman contact
type ContactHandler struct {
	service service.ContactService
	tmpl    *template.Template
}

// NewContactHandler constructor untuk ContactHandler
func NewContactHandler(svc service.ContactService) *ContactHandler {
	// Parse templates
	tmpl := template.Must(template.ParseFiles(
		filepath.Join("views", "layouts", "header.html"),
		filepath.Join("views", "layouts", "footer.html"),
		filepath.Join("views", "pages", "contact.html"),
	))
	return &ContactHandler{service: svc, tmpl: tmpl}
}

// ContactPageView menangani GET /contact - menampilkan halaman contact
func (h *ContactHandler) ContactPageView(w http.ResponseWriter, r *http.Request) {
	// Data untuk template
	data := struct {
		Title string
	}{
		Title: "Contact Us",
	}

	// Render template
	w.Header().Set("Content-Type", "text/html")
	if err := h.tmpl.ExecuteTemplate(w, "contact", data); err != nil {
		http.Error(w, "Template Error", http.StatusInternalServerError)
	}
}

// SendMessageHandler menangani POST /contact/send
func (h *ContactHandler) SendMessageHandler(w http.ResponseWriter, r *http.Request) {
	// Parse form data
	if err := r.ParseForm(); err != nil {
		http.Error(w, "Bad Request", http.StatusBadRequest)
		return
	}

	// Create DTO from form
	contactReq := &dto.ContactRequest{
		Name:    r.FormValue("name"),
		Email:   r.FormValue("email"),
		Subject: r.FormValue("subject"),
		Message: r.FormValue("message"),
		Phone:   r.FormValue("phone"),
	}

	// Get client IP and User-Agent
	ip := r.RemoteAddr
	userAgent := r.UserAgent()

	// Convert DTO to model
	contact := &model.ContactMessage{
		Name:      contactReq.Name,
		Email:     contactReq.Email,
		Subject:   &contactReq.Subject,
		Message:   contactReq.Message,
		Phone:     &contactReq.Phone,
		IPAddress: &ip,
		UserAgent: &userAgent,
	}

	// Save to database via service
	if err := h.service.CreateContactMessage(r.Context(), contact); err != nil {
		log.Printf("Error saving contact message: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	log.Printf("Contact form submitted and saved - Name: %s, Email: %s", contactReq.Name, contactReq.Email)

	// Redirect back to contact page with success message
	http.Redirect(w, r, "/contact?success=1", http.StatusSeeOther)
}

// AuthHandler stub untuk auth
type AuthHandler struct{}

// LoginView menangani GET /login
func (h *AuthHandler) LoginView(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Login Page"))
}

// Login menangani POST /login
func (h *AuthHandler) Login(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Login Processed"))
}

// Handler struct utama yang menampung semua handler
type Handler struct {
	HomeHandler       *HomeHandler
	AboutHandler      *AboutHandler
	DownloadHandler   *DownloadHandler
	ContactHandler    *ContactHandler
	AuthHandler       *AuthHandler
	PortofolioHandler *PortofolioHandler
}

// NewHandler constructor untuk Handler utama
func NewHandler(svc *service.Service) *Handler {
	return &Handler{
		HomeHandler:       NewHomeHandler(svc.ProjectService),
		AboutHandler:      NewAboutHandler(),
		DownloadHandler:   &DownloadHandler{},
		ContactHandler:    NewContactHandler(svc.ContactService),
		AuthHandler:       &AuthHandler{},

		PortofolioHandler: NewPortofolioHandler(svc.ProjectService),
	}
}



func getFileSize(filePath string) int64 {
	fi, err := os.Stat(filePath)
	if err != nil {
		log.Printf("Error getting file size: %v", err)
		return 0
	}
	return fi.Size()
}
